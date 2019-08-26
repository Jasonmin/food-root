var mysql = require('mysql');
var connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '3366',
    database: 'users'
});

connection.connect();

connection.query('SELECT * from food', function(error, results, fields) {
    if (error) throw error;
    console.log('The results is: ', results[0]);
    var item = results[0];

    console.log(item.title);
});