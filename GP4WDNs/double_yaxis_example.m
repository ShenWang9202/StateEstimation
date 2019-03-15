monthnum = 1:12;  
precip = [3.4 3.3 4.3 3.7 3.5 3.7 ...    
             3.4 3.4 3.4 3.9 4.0 3.8];
temp = [16 25 40 48 59 70 ...
             77 77 65 56 47 34];
low = [22 25 31 41 50 60 ...
                65 65 57 47 38 28];
high = [36 39 45 56 66 76 ... 
                81 80 72 61 51 41];
figure
yyaxis left
plot(monthnum,precip)
xlabel('Month')
ylabel('Precipitation')
title('Monthly Climate Data')
yyaxis right
plot(monthnum,temp)
ylabel('Temperature')
hold on
plot(monthnum,low)
plot(monthnum,high)
ylabel('Temperature')
legend('Precipitation','Temperature','Low','High')
hold off