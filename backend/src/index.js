const mysql = require("mysql");
const express = require('express');
const app = express();

const db = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "",
    database: "students_info"
});
db.connect();

app.listen("3000", () => {
    console.log("server started on port 3000");
});

app.get('/', function (req, res) {
    res.send('Server Running');
});
app.get('/connect', async function (req, res) {
    try {
        db.query('SELECT * FROM students', (error, results, fields) => {
            if (error) {
                res.status(500).json({ error: error.message });
                return;
            }

            // Check if results is an array
            if (Array.isArray(results)) {
                res.json(results);
            } else {
                // If not an array, send an error response
                res.status(500).json({ error: "Query did not return expected results" });
            }
        });
    } catch (error) {
        // Catch any other errors
        res.status(500).json({ error: error.message });
    }
});




