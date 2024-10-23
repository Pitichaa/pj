const express = require('express');
const bodyParser = require('body-parser');
const { Pool } = require('pg');
const path = require('path');

const app = express();
const port = 3000;

// ตั้งค่าการเชื่อมต่อ PostgreSQL
const pool = new Pool({
    user: 'postgres', // ชื่อผู้ใช้ PostgreSQL ของคุณ
    host: 'localhost',
    database: 'database', // ชื่อฐานข้อมูลของคุณ
    password: 'rootroot', // รหัสผ่าน PostgreSQL ของคุณ
    port: 5432,
});

// ตั้งค่า middleware
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static('public'));

// หน้าแรก (Welcome)
app.get('/', (req, res) => {
    res.render('welcome');
});

// หน้าเช็คชื่อ
app.get('/check-attendance', (req, res) => {
    res.render('index');
});

// เช็คชื่อและบันทึกข้อมูล
app.post('/check-attendance', async (req, res) => {
    const { student_id, section_id } = req.body;

    // ตรวจสอบว่าได้ระบุ section_id หรือไม่
    if (!section_id) {
        res.render('index', { errorMessage: 'กรุณาเลือก Section!', message: undefined });
        return;
    }

    const activeDate = new Date(); // กำหนดเวลาเป็นปัจจุบัน

    try {
        // ตรวจสอบว่านักเรียนมีอยู่ในตาราง student หรือไม่
        const studentQuery = 'SELECT * FROM student WHERE id = $1';
        const studentResult = await pool.query(studentQuery, [student_id]);

        // ถ้านักเรียนไม่มีในตาราง ให้แจ้งเตือน
        if (studentResult.rowCount === 0) {
            res.render('index', { errorMessage: 'รหัสนักเรียนไม่ถูกต้อง!', message: undefined });
            return;
        }

        // คำสั่ง SQL สำหรับการบันทึกข้อมูลเช็คชื่อ
        const attendanceQuery = `
            INSERT INTO student_list (student_id, section_id, active_date)
            VALUES ($1, $2, $3)
        `;

        // บันทึกข้อมูลลงในฐานข้อมูล
        await pool.query(attendanceQuery, [student_id, section_id, activeDate]);

        // ส่งข้อความสำเร็จกลับไปยังหน้า index
        res.render('index', { message: 'เรียบร้อย!', errorMessage: undefined });
    } catch (error) {
        console.error(error);
        res.render('index', { errorMessage: 'ข้อมูลผิดพลาด! กรุณาลองใหม่อีกครั้ง.', message: undefined });
    }
});

// หน้าแสดงรายชื่อนักเรียนที่เช็คชื่อแล้ว
app.get('/student_list', async (req, res) => {
    const { searchId } = req.query;

    let query = `
        SELECT student_list.student_id, student_list.section_id, student_list.active_date, 
               student.first_name, student.last_name, curriculum.short_name_en
        FROM student_list
        JOIN student ON student_list.student_id = student.id
        JOIN curriculum ON student.curriculum_id = curriculum.id
    `;
    const values = [];

    // ถ้ามีการค้นหารหัสนักเรียน
    if (searchId && searchId.trim() !== '') {
        query += ' WHERE student_list.student_id = $1'; // เพิ่มWHERE
        values.push(searchId);
    }

    query += ' ORDER BY student_list.active_date DESC'; // ย้ายORDER BYออกไปนอกเงื่อนไข WHERE

    try {
        const result = await pool.query(query, values);
        res.render('student_list', {
            attendanceRecords: result.rows,
            errorMessage: null // ส่งค่าข้อความผิดพลาดเป็น null
        });
    } catch (error) {
        console.error(error);
        res.render('student_list', {
            attendanceRecords: [],
            errorMessage: 'เกิดข้อผิดพลาดในการดึงข้อมูล' // ส่งค่าข้อความผิดพลาด
        });
    }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});