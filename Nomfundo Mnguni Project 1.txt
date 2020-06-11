/*--------------------QUESTION 1: Importing data----------------------*/
FILENAME REFFILE '/folders/myfolders/Comcast_telecom_complaints_data.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.COMCAST1;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.COMCAST1;
 RUN;
 
 /*----------------QUESTION 2: Series Plot-------------------------*/
ods graphics / reset width=6.4in height=4.8in imagemap groupmax=1900;

proc sort data=WORK.COMCAST1 out=_SeriesPlotTaskData;
	by Date;
run;

proc sgplot data=_SeriesPlotTaskData;
	series x=Date y=Ticket__ / group=Customer_Complaint;
	xaxis grid;
	yaxis grid;
run;

ods graphics / reset;

proc datasets library=WORK noprint;
	delete _SeriesPlotTaskData;
	run;
	
/*--------------QUESTION 3: Proc Freq Table--------------------------*/
	
Proc freq data=WORK.COMCAST1; tables Customer_Complaint;
run;
Data Complaint1;
set WORK.COMCAST1;
Length Complaint_Type $15.;
if Customer_Complaint="internet" then Complaint_Type="Internet";
if Customer_Complaint="Comcast" then Complaint_Type="Network";
else Complaint_Type="Other";
run;
 
 
 /*-----------QUESTION 4: If-then-else-----------------------------*/
Data Complaint4;
set WORK.COMCAST1; 
LENGTH Status2 $8.;
if Status="Open" or Status= "Pending" then Status2= "Open"; else Status2="Closed";
run;

/*-----------QUESTION 5: Bar Chart------------------------------*/

ods graphics / reset width=6.4in height=4.8in imagemap groupmax=1900;

proc sgplot data=WORK.COMCAST1;
	vbar State / group=Customer_Complaint groupdisplay=stack stat=percent;
	yaxis grid;
run;

ods graphics / reset;

/* Note that the third quartile is less congested with complaints which might imply that most complaints are resolved by then*/

/*-----------QUESTION 6: Proc freq percentile------------------*/

Proc sort data=WORK.COMCAST1;
by Date;
run;
Proc freq data=WORK.COMCAST1;
 table Received_Via*Status2;
 run;


