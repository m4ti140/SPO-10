function M=crosssection_estimate(x,y)

    if mod(size(x,2),2)==0||mod(size(y,2),2)==0
        error("matrix must dimensions must be odd")
        return
    end
    M=zeros(size(x,2),size(y,2));
    M(ceil(size(x,2)/2),:)=y;
    M(:,ceil(size(y,2)/2))=x;
    for i=2:floor(size(x,2)/2)   %pierwsza cwiartka
        for j=2:floor(size(y,2)/2)
            rx=ceil(size(x,2)/2)-i;
            ry=ceil(size(y,2)/2)-j;
            r=sqrt(rx^2+ry^2);
            xm=interp1((-floor(size(x,2)/2):floor(size(x,2)/2)),x, -r, 'pchip', 0);
            ym=interp1((-floor(size(y,2)/2):floor(size(y,2)/2)),y, -r, 'pchip', 0);
            M(i,j)=(xm*rx+ym*ry)/(rx+ry);
        end
    end
    for i=2:floor(size(x,2)/2)   %druga cwiartka
        for j=ceil(size(y,2)/2)+1:size(y,2)-1
            rx=ceil(size(x,2)/2)-i;
            ry=j-ceil(size(y,2)/2);
            r=sqrt(rx^2+ry^2);
            xm=interp1((-floor(size(x,2)/2):floor(size(x,2)/2)),x, -r, 'pchip', 0);
            ym=interp1((-floor(size(y,2)/2):floor(size(y,2)/2)),y, r, 'pchip', 0);
            M(i,j)=(xm*rx+ym*ry)/(rx+ry);
        end
    end
    for i=ceil(size(x,2)/2)+1:size(x,2)-1   %czwarta cwiartka
        for j=2:floor(size(y,2)/2)
            rx=i-ceil(size(x,2)/2);
            ry=ceil(size(y,2)/2)-j;
            r=sqrt(rx^2+ry^2);
            xm=interp1((-floor(size(x,2)/2):floor(size(x,2)/2)),x, r, 'pchip', 0);
            ym=interp1((-floor(size(y,2)/2):floor(size(y,2)/2)),y, -r, 'pchip', 0);
            M(i,j)=(xm*rx+ym*ry)/(rx+ry);
        end
    end
    for i=ceil(size(x,2)/2)+1:size(x,2)-1   %trzecia cwiartka
        for j=ceil(size(y,2)/2)+1:size(y,2)-1
            rx=i-ceil(size(x,2)/2);
            ry=j-ceil(size(y,2)/2);
            r=sqrt(rx^2+ry^2);
            xm=interp1((-floor(size(x,2)/2):floor(size(x,2)/2)),x, r, 'pchip', 0);
            ym=interp1((-floor(size(y,2)/2):floor(size(y,2)/2)),y, r, 'pchip', 0);
            M(i,j)=(xm*rx+ym*ry)/(rx+ry);
        end
    end

end