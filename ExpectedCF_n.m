%make expected revenues based on average CF and price curve
%needed for the Excel calculation
%when price levels are above floor SP and Mer will be the same

function[EXP_CF,EXP_CF_All,EXP_CF_All_y,Prod_Year_EXP,Mer_EXP_rev,CfD_EXP_rev,SP_EXP_rev] = ExpectedCF_n(meanCF20,meanCF25,meanCF30,...
    meanCF35,meanCF40,meanCF45,meanCF50,Hours_Year_EXPRev,fundamental_price_level)

Price_floor = 45;

%combine CF of all years into one matrix and make an average
EXP_CF = cat(1,meanCF20,meanCF25,meanCF30,meanCF35,meanCF40,meanCF45,meanCF50);
EXP_CF_All = mean(EXP_CF);

%copy the average CF 31 in a 1x31 matrix
EXP_CF_All_y = repmat(EXP_CF_All,1,31);

%YearlyProduction
Prod_Year_EXP = Hours_Year_EXPRev.* EXP_CF_All_y;

%Calculate revenues

%Merchant EXP revenues
Mer_EXP_rev =  Prod_Year_EXP.* fundamental_price_level;

%CfD EXP revenues
CfD_EXP_rev =  Prod_Year_EXP.* Price_floor; 

%SP EXP revenues
SP_EXP_rev =zeros(1,31);
for x=1
    for y=1:31
        if fundamental_price_level(x,y) < Price_floor
           SP_EXP_rev(x,y) = Price_floor * Prod_Year_EXP (x,y); 
           
       elseif fundamental_price_level(x,y) > Price_floor
           SP_EXP_rev(x,y) = fundamental_price_level(x,y) * Prod_Year_EXP (x,y); 
           
       else fundamental_price_level(x,y) = Price_floor;
           SP_EXP_rev(x,y) = Price_floor * Prod_Year_EXP (x,y);
           
        end
    end
end
end

  
 
 