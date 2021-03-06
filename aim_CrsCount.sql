USE [AIM]
GO
/****** Object:  StoredProcedure [dbo].[aim_CrsCount]    Script Date: 1/2/2018 1:55:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER Procedure [dbo].[aim_CrsCount]
as
select * from openquery(CARS, 'select sec_rec.fac_id, id_rec.fullname, sec_rec.yr || sec_rec.sess as YrSess,  count(crs_rec.crs_no) as CrsCount
from id_rec,
    sec_rec,
    crs_rec,
    dept_table,
    outer fac_rec,
    mtg_rec,
    secmtg_rec
where     
        ((sec_rec.sess in ( "FA", "SP", "IN", "S1", "S2", "SU"))
       and (sec_rec.yr in (2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012,2013,2014, 2015, 2016, 2017, 2018)))
       and sec_rec.cat in ("UG04","UG05","UG06", "UG07","UG08", "UG09", "UG10", "UG11", "UG12", "UG13", "UG14", "UG15", "UG16", "UG17", "UG18")
        and sec_rec.fac_id = id_rec.id
        and secmtg_rec.cat = sec_rec.cat
        and crs_rec.cat = sec_rec.cat
        and  sec_rec.crs_no = crs_rec.crs_no
        and sec_rec.fac_id = fac_rec.id
        and mtg_rec.mtg_no = secmtg_rec.mtg_no
        and sec_rec.crs_no = secmtg_rec.crs_no
        and sec_rec.sec_no = secmtg_rec.sec_no
        and sec_rec.sess = secmtg_rec.sess
        and sec_rec.yr = secmtg_rec.yr
        and sec_rec.cat = secmtg_rec.cat
        and secmtg_rec.sess = mtg_rec.sess
        and secmtg_rec.yr = mtg_rec.yr
        and dept_table.dept = crs_rec.dept
        and sec_rec.stat <> "X"
    
        
        Group by sec_rec.fac_id,id_rec.fullname, sec_rec.yr,  sec_rec.sess
        Order by id_rec.fullname,sec_rec.yr || sec_rec.sess ')
   --select * from SCHED    