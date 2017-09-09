var sql = require("mssql");

// async () => {
//     try {
//         const pool = await sql.connect('mssql://ra:njkmrjcdjb@10.0.18.3/ERBD_EGE_MAIN_17_Fresh_20170424')
//         const value = 3
//         const result = await sql.query`select * from rbd_Participants where REGION = ${value}`
//         console.dir(result)
//     } catch (err) {
//         // ... error checks 
//     }
// }