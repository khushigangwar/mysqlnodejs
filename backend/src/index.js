const mysql=require("mysql");
const express=require('express');
const app=express();
const db=mysql.createConnection({
    host:"localhost",
    user:"root",
    password:"",
    database:"students_info"
});
db.connect((error)=>{
    if(error){
        throw error;
    }
    console.log("database conneted");
});

app.get('/allstudents',(req,res)=>{
    db.query('Select * from students',(err,rows,fields)=>{
        if(!err){
            res.json(rows);
        }
        else{
            console.log(err);
        }
    });
});
    app.listen("3000",()=>{
        console.log("server started on port 3000");
    });
