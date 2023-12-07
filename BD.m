tic;
clc
clear
global a b c d kk e
figure
L=301;A=linspace(-10,-8,L);
a=4.1;b=-2;e=0.5;d=0.8;kk=0.2;
x1(1)=0.1;y1(1)=-0.1;z1(1)=0.2;
for k=1:L
    disp(k)
    c=A(k);
    for i=1:100000
x1(i+1)=a/(1+x1(i)*x1(i))+b+kk*(c+d*sin(y1(i)))*z1(i);
y1(i+1)=y1(i)+e*z1(i);
z1(i+1)=z1(i)+e*x1(i);
    end 
   u1=x1(1,end-10000:end);
   plot(A(k)*ones(1,length(u1)),u1,'.','Markersize',3,'color','#e3008c');hold on;
end
toc;
xlabel('\itc','fontsize',20)
ylabel('\itx\rm(\itn\rm)','fontsize',20)
set(gca, 'fontsize',20);set(gca, 'LineWidth',1.5);set(gca,'Fontname','times new Roman');