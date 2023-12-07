clc;clear;
a=4.1;b=-2;d=0.8;kk=0.1;c=-8;e=0.1;
x1(1)=0.1;y1(1)=-0.1;z1(1)=0.2;
for i=1:100000 
x1(i+1)=a./(1+x1(i)*x1(i))+b+kk*(c+d*sin(y1(i)))*z1(i);
y1(i+1)=y1(i)+e*z1(i);
z1(i+1)=z1(i)+e*x1(i);
end
 t=1:1:10001;
figure;
plot(t(2000:2200),x1(2000:2200),'b');hold on;
figure;
plot(x1(50000:80000),z1(50000:80000),'.','Markersize',3,'color','#d29200');hold on
xlabel('\itx\rm(\itn\rm)');ylabel('\itz\rm(\itn\rm)');
set(gca, 'fontsize', 20);set(gca, 'LineWidth', 1.5);set(gca,'Fontname','times new Roman');
