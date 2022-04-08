clear all

%read merchant and CfD Shareholder value (2) from an Excel file
%run just once to get data from all scenarios
%save the new files and load into DebtFit_2
filename1 = 'M:\Mak Folder\PAPERS\Paper C\#### EXCEL MAIN ####\Solved runs\Mod_(44)_R001_Base.xlsm';    %base case high 
filename2 = 'M:\Mak Folder\PAPERS\Paper C\#### EXCEL MAIN ####\Solved runs\Mod_(45)_R001_0a).xlsm';     %average fin both
filename3 = 'M:\Mak Folder\PAPERS\Paper C\#### EXCEL MAIN ####\Solved runs\Mod_(45)_R001_2a).xlsm';     %DSCR average both 
filename4 = 'M:\Mak Folder\PAPERS\Paper C\#### EXCEL MAIN ####\Solved runs\Mod_(45)_R001_2b).xlsm';     %loan tenor average
filename5 = 'M:\Mak Folder\PAPERS\Paper C\#### EXCEL MAIN ####\Solved runs\Mod_(45)_R001_5a).xlsm';     %COE down 20% mer, up 20% CfD
filename6 = 'M:\Mak Folder\PAPERS\Paper C\#### EXCEL MAIN ####\Solved runs\Mod_(45)_R001_5e).xlsm';     %COD up 20% for both
filename7 = 'M:\Mak Folder\PAPERS\Paper C\#### EXCEL MAIN ####\Solved runs\Mod_(45)_R001_6a).xlsm';     %COD down 20% for both
filename8 = 'M:\Mak Folder\PAPERS\Paper C\#### EXCEL MAIN ####\Solved runs\Mod_(45)_R001_6b).xlsm';     %COE up 20% for both
filename9 = 'M:\Mak Folder\PAPERS\Paper C\#### EXCEL MAIN ####\Solved runs\Mod_(45)_R001_6c).xlsm';     %COE down 20% for both
filename10 = 'M:\Mak Folder\PAPERS\Paper C\#### EXCEL MAIN ####\Solved runs\Mod_(45)_R001_6d).xlsm';     %DSCR up 20% for both
filename11 = 'M:\Mak Folder\PAPERS\Paper C\#### EXCEL MAIN ####\Solved runs\Mod_(45)_R001_6e).xlsm';     %DSCR down 20% for both
filename12 = 'M:\Mak Folder\PAPERS\Paper C\#### EXCEL MAIN ####\Solved runs\Mod_(45)_R001_6f).xlsm';     %TENOR up 20% for both
filename13 = 'M:\Mak Folder\PAPERS\Paper C\#### EXCEL MAIN ####\Solved runs\Mod_(45)_R001_6g).xlsm';     %TENOR down 20% for both

CfD_Sv1 = xlsread(filename1,'Overview','C14:M14');
CfD_Sv2 = xlsread(filename2,'Overview','C14:M14');
CfD_Sv3 = xlsread(filename3,'Overview','C14:M14');
CfD_Sv4 = xlsread(filename4,'Overview','C14:M14');
CfD_Sv5 = xlsread(filename5,'Overview','C14:M14');
CfD_Sv6 = xlsread(filename6,'Overview','C14:M14');
CfD_Sv7 = xlsread(filename7,'Overview','C14:M14');
CfD_Sv8 = xlsread(filename8,'Overview','C14:M14');
CfD_Sv9 = xlsread(filename9,'Overview','C14:M14');
CfD_Sv10 = xlsread(filename10,'Overview','C14:M14');
CfD_Sv11 = xlsread(filename11,'Overview','C14:M14');
CfD_Sv12 = xlsread(filename12,'Overview','C14:M14');
CfD_Sv13 = xlsread(filename13,'Overview','C14:M14');

Mer_Sv1 = xlsread(filename1,'Overview','C15:M15');
Mer_Sv2 = xlsread(filename2,'Overview','C15:M15');
Mer_Sv3 = xlsread(filename3,'Overview','C15:M15');
Mer_Sv4 = xlsread(filename4,'Overview','C15:M15');
Mer_Sv5 = xlsread(filename5,'Overview','C15:M15');
Mer_Sv6 = xlsread(filename6,'Overview','C15:M15');
Mer_Sv7 = xlsread(filename7,'Overview','C15:M15');
Mer_Sv8 = xlsread(filename8,'Overview','C15:M15');
Mer_Sv9 = xlsread(filename9,'Overview','C15:M15');
Mer_Sv10 = xlsread(filename10,'Overview','C15:M15');
Mer_Sv11 = xlsread(filename11,'Overview','C15:M15');
Mer_Sv12 = xlsread(filename12,'Overview','C15:M15');
Mer_Sv13 = xlsread(filename13,'Overview','C15:M15');
