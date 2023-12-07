clear;clc
global a b c d kk e
% a=4.1;b=-2;c=-8;d=0.8;kk=0.1;
% a=4.1;b=-2;e=0.5;c=-8;kk=0.2;
a=4.21;b=-1.2;d=0.9;kk=0.36;e=0.001;

Q=eye(3);
L1(1)=0;L2(1)=0;L3(1)=0;
L=200;
A=linspace(-10,-8,L);
for k=1:L
    disp(k)
    c=A(k);
      x(1)=0.5;   
     y(1)=0;
     z(1)=-1;
for i=1:100000
    x(i+1)=a/(1+x(i)*x(i))+b+kk*(c+d*sin(y(i)))*z(i);
    y(i+1)=y(i)+e*z(i);
    z(i+1)=z(i)+e*x(i);
    
      Xx=-(2*a*x(i))/(x(i)^2+1)^2;
      Xy=d*kk*z(i)*cos(y(i));
      Xz=kk*(c+d*sin(y(i)));
        
      Yx=0;
      Yy=1;
      Yz=e;
        
        Zx=e;
        Zy=0;
        Zz=1;
        
        
    
        J=[Xx Xy Xz;Yx Yy Yz;Zx Zy Zz];
        B=J*Q;
        [Q,R]=qr(B);
L1(i+1)=log(abs(R(1,1)));
L2(i+1)=log(abs(R(2,2)));
L3(i+1)=log(abs(R(3,3)));
end
L11(k)=sum(L1(95000:end))/5000;
L22(k)=sum(L2(95000:end))/5000;
L33(k)=sum(L3(95000:end))/5000;
x1(k)=A(k);y1(k)=L11(k);y2(k)=L22(k);y3(k)=L33(k);
end
figure
plot(x1,y1,'r',x1,y2,'g',x1,y3,'b','linewidth',1.5);
xlabel('\itc','fontsize',20)
ylabel('LEs','fontsize',20)
set(gca, 'fontsize', 20);set(gca, 'LineWidth', 1.5);set(gca,'Fontname','times new Roman');
