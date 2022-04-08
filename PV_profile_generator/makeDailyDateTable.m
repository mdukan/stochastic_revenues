%help function to create tables with date (daily, not hourly)

function table=makeDailyDateTable(startD,startM,startY,endD, endM,endY,array)

t1=datetime(startY,startM,startD,'Format','dd.MM.yyyy');
t2=datetime(endY,endM,endD,'Format','dd.MM.yyyy');

date=t1:t2;

table=array2table(array);
table.date=date';

end