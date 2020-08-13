%%This code is meant to intialise random parameters for dual band PIFA and
%%save the results in a database meant to be used as training data for CGAN
%%
%%First make sure correct Antenna is open on CST

%C1,C2,C3,C4 are the fold gaps. 
%X1,X2,X3 are the gap between the elements.
%b=[ x2 x3 x4 x5 c2 c3 c4 c5]
%Consider three variables x1,x2, and x3 with ranges a1,2,3-b1,2,3%
 b=[2 35 70 12 7 19 3.19 14.53 0.01 2.6 3.16 0.489 20];
 a=[11 45 90 19.5 13 26 5.7 18.53 0.07 3.1 6.16 4.489 25];
 it=3;
 r=rand(it,13);%size of the data we need
 for j=1:it
     for i=1:13
         M(j,i)=(b(i)-a(i)).*r(j,i)+a(i);
     end
 end
%filename = 'preds_v3_2.csv';
%M = csvread(filename)

Output = zeros(5001,it);

for i=1:it
    CST = actxserver('CSTStudio.Application');
    mws = CST.invoke('Active3D');
    solv=mws.invoke('Solver');
    plot1d=mws.invoke('Plot1d');
    export=mws.invoke('ASCIIExport');
    mws.invoke('StoreDoubleParameter','He',M(i,1));
    mws.invoke('StoreDoubleParameter','Le',M(i,2));
    mws.invoke('StoreDoubleParameter','Lg',M(i,3));
    mws.invoke('StoreDoubleParameter','Lps',M(i,4));
    mws.invoke('StoreDoubleParameter','Ls1',M(i,5));
    mws.invoke('StoreDoubleParameter','Ls2',M(i,6));
    mws.invoke('StoreDoubleParameter','Ls3',M(i,7));
    mws.invoke('StoreDoubleParameter','Ls4',M(i,8));
    mws.invoke('StoreDoubleParameter','x',M(i,9));
    mws.invoke('StoreDoubleParameter','Wh',M(i,10));
    mws.invoke('StoreDoubleParameter','Wp',M(i,11));
    mws.invoke('StoreDoubleParameter','Ws',M(i,12));
    mws.invoke('StoreDoubleParameter','Lp1',M(i,13));
    invoke(export,'reset');
    mws.invoke('Rebuild');
    
    solv.invoke('Start');
    exportpathr = 'C:\Users\Jay\Documents\MATLAB\Cgan\Sparams.txt';
   %exportpathi = 'C:\Users\Jay\Documents\MATLAB\Cgan\Zimag.txt';
   
    filenameTXT1 = 'Sparams';
    %filenameTXT2 = 'Zimag';
    
    CstExportSparametersTXT(mws, exportpathr);
    %CstExportZparametersimagTXT(mws, exportpathi);
 
% fidi = fopen( 'surjendo Zreal.txt','r');
    [ Freq, S11] = textread('Sparams.txt', '%f %f','headerlines', 2);
    %[ Freq, Zimag] = textread('Zimag.txt', '%f %f','headerlines', 2);
        
    

     for(j=1:5001)
       %Q(j)=(omega(j)/(2*Zreal(j)))*sqrt((dr(j)^2)+(dx(j)+(abs(dx(j))/omega(j)))^2);
       Output(j,it) = S11(j)     
     end
           
  %cost = cost/1000;
  %Output(i)=cost 
  end
csvwrite('S11_trial1.csv',Output)