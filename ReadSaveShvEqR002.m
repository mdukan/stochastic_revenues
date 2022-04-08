clear all

%read merchant and CfD Shareholder value (2) from an Excel file
%run just once to get data from all scenarios
%save the new files and load into DebtFit_2
filename1 = 'M:\Mak Folder\PAPERS\Paper C\#### EXCEL MAIN ####\Solved runs\Mod_(45)_R002_7c).xlsm';    %low equity
filename2 = 'M:\Mak Folder\PAPERS\Paper C\#### EXCEL MAIN ####\Solved runs\Mod_(45)_R002_7b).xlsm';    %high equity

CfD_Sv1 = xlsread(filename1,'Overview','C14:M14');
CfD_Sv2 = xlsread(filename2,'Overview','C14:M14');

Mer_Sv1 = xlsread(filename1,'Overview','C15:M15');
Mer_Sv2 = xlsread(filename2,'Overview','C15:M15');

