longString = %q{
SELECT     regions.regionname, 
          case when rtbl.number IS NULL THEN ""''"" ELSE cast(rtbl.number AS varchar) END AS rshts
          ,case when abtbl.number IS NULL THEN ""''"" ELSE cast(abtbl.number AS varchar) END AS abshts
          ,case when ctbl.number IS NULL THEN ""''"" ELSE cast(ctbl.number AS varchar) END AS cshts
          ,case when compltbl.number IS NULL THEN ""''"" ELSE cast(compltbl.number AS varchar) END AS complshts
          ,case when httbl.number IS NULL THEN ""''"" ELSE cast(httbl.number AS varchar) END AS htshts
          ,case when ptbl.number IS NULL THEN ""''"" ELSE cast(ptbl.number AS varchar) END AS pshts
          
          --,case when queries.quantity IS NULL THEN ""''"" ELSE cast(queries.quantity AS varchar) END AS query
          ,--case when queries.quantity IS NULL THEN ""''"" ELSE cast(queries.quantity AS varchar) + ""'""(""'"" + 
                                                                       case when queries1.quantity IS NULL THEN ""''""  ELSE
                                                                                     cast(queries1.quantity AS varchar)  END  --+ ""'"")""'"" END AS query
          
          ,case when finished.FTime IS NULL THEN ""''"" ELSE finished.FTime END AS Finished
FROM         (SELECT     regioncode, CAST(rbdc_Regions.Region AS varchar) + ""'"" - ""'"" + rbdc_Regions.RegionName AS regionname
FROM         sca_Departments INNER JOIN
                      rbdc_Regions ON sca_Departments.RegionCode = rbdc_Regions.Region
WHERE     (sca_Departments.DepartmentCode LIKE ""'""__00""'"") AND 
          (LEFT(sca_Departments.DepartmentCode, 2) NOT IN (""'""99""'"", ""'""00""'"", ""'""80""'"", ""'""81""'"", ""'""84""'"", ""'""85""'""))) regions LEFT OUTER JOIN

                          (SELECT     sht_Sheets_R.REGION as REGION, COUNT(*) AS number
FROM         sht_Sheets_R with (nolock)
WHERE     (51 = 0 OR sht_Sheets_R.subjectcode = 51) AND sht_Sheets_R.ExamDate = ""'""2017.09.05""'""
GROUP BY sht_Sheets_R.REGION) rtbl ON regions.RegionCode = rtbl.REGION 

LEFT OUTER JOIN

                          (SELECT     sht_Sheets_AB.REGION as REGION, COUNT(*) AS number
FROM         sht_Sheets_AB with (nolock)
WHERE     (51 = 0 OR sht_Sheets_AB.subjectcode = 51) AND sht_Sheets_AB.ExamDate = ""'""2017.09.05""'""
GROUP BY sht_Sheets_AB.REGION) abtbl ON regions.RegionCode = abtbl.REGION 

LEFT OUTER JOIN

                          (SELECT     sht_Sheets_C.REGION as REGION, COUNT(*) AS number
FROM         sht_Sheets_C with (nolock)
WHERE     (51 = 0 OR sht_Sheets_C.subjectcode = 51) AND sht_Sheets_C.ExamDate = ""'""2017.09.05""'""
                  and DeleteType = 0
GROUP BY sht_Sheets_C.REGION) ctbl ON regions.RegionCode = ctbl.REGION 

LEFT OUTER JOIN

                          (SELECT     res_Complects.REGION, COUNT(*) AS number
FROM         res_Complects with (nolock)
WHERE     ((SheetFK_R IS NOT NULL) --AND (SheetFK_AB IS NOT NULL) 
                  AND (SheetFK_C IS NOT NULL)
                  OR (ExchangedID IS NOT NULL)
                  )
          and (51 = 0 OR res_complects.subjectcode = 51) AND examDate = ""'""2017.09.05""'""
GROUP BY res_Complects.REGION) compltbl ON regions.RegionCode = compltbl.REGION 

LEFT OUTER JOIN

                          (SELECT     REGION, COUNT(*) AS number
FROM         res_HumanTests with (nolock)
where (51 = 0 OR subjectcode = 51) and examdate  = ""'""2017.09.05""'""
GROUP BY REGION) httbl ON regions.RegionCode = httbl.REGION 

LEFT OUTER JOIN

                          (SELECT     REGION, COUNT(*) AS number
FROM         res_HumanTests with (nolock)
where (51 = 0 OR subjectcode = 51) and examdate  = ""'""2017.09.05""'"" and ReplicationCondition = 5
GROUP BY REGION) ptbl ON regions.RegionCode = ptbl.REGION 

LEFT OUTER JOIN

(

SELECT     rbd_ParticipantsExamsOnStation.Region, 
                  COUNT(ParticipantID) AS quantity
FROM         rbd_ParticipantsExamsOnStation with (nolock) INNER JOIN
                      rbd_ParticipantsExams with (nolock) ON rbd_ParticipantsExamsOnStation.Region = rbd_ParticipantsExams.REGION AND 
                      rbd_ParticipantsExamsOnStation.ParticipantsExamsID = rbd_ParticipantsExams.ParticipantsExamsID INNER JOIN
                      dat_Exams with (nolock) ON rbd_ParticipantsExamsOnStation.ExamGlobalID = dat_Exams.ExamGlobalID
WHERE     (dat_Exams.SubjectCode = 0 OR dat_Exams.SubjectCode = 51) AND (dat_Exams.ExamDate = ""'""2017.09.05""'"")     
GROUP BY   rbd_ParticipantsExamsOnStation.Region    ) queries1

ON regions.RegionCode = queries1.Region 


LEFT OUTER JOIN

(SELECT   REGION, MAX(FinishTime) AS FTime
FROM         sht_ExamFinish with (nolock)
WHERE     (51 = 0 OR sht_ExamFinish.SubjectCode = 51) AND (sht_ExamFinish.ExamDate = ""'""2017.09.05""'"")
GROUP BY REGION) finished 
ON regions.RegionCode = finished.REGION
ORDER BY regions.RegionCode
}

goodstrings = %Q[Dim lStr As String \n lStr = ""\n]

longString = longString.split(/\n/)

longString.each do |line|
    goodstrings += %Q{lStr = lStr & " #{line} "\n}
end

File.open('d:\rubies\vb_longline.txt', 'w:windows-1251') do |file|
    file.write goodstrings
end