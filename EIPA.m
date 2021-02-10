clear all;close all;clc;

%EIPA PA#5 ELEC4700
%Adam Gauthier 100947233
nx=50;
ny=50;
V=zeros(nx,ny);
G=sparse(nx*ny,nx*ny);

% Make G matrix diagonal 1, else 0 then implement difference eq
for i=1:nx
    for j=1:ny
        n=j+(i-1)*ny; %mapping eq
        if i==1 || j==1 || i==nx || j==ny
            G(n,:)=0;
            G(n,n)=1; % diagonal all ones
        else
            G(n,n)=-4; % difference eq but surrounding cells all 0, get -4*1
            G(n,n+1)=1;
            G(n,n-1)=1;
            G(n,n+ny)=1;
            G(n,n-ny)=1;
        end
    end
end

figure('name', 'Spy(G)');
spy(G)

%plot eigenvals
modes=9;
[E,D] = eigs(G,modes,'SM');
figure('name','Eigen Vals');
plot(diag(D),'*');

figure('name','Modes');
for q = 1:modes
    M=E(:,q);
    for i=1:nx
        for j=1:ny
            n=j+(i-1)*ny; %mapping eq
            V(i,j)=M(n);
        end
        subplot(3,3,q);
        surf(V);
        title(['EV = ' num2str(D(q,q))])
    end
end

