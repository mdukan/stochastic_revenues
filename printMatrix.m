function printMatrix(Matrix,MatrixName,index1,index2,filename)
    rows = length(Matrix(:,1));
    cols = length(Matrix(1,:));
  
    format short
    s1 = cell(cols+1,1);
    for i=1:cols
        s1(i+1)=cellstr([index2,int2str(i)]);
    end
    s2 = cell(rows,1);
    for i=1:rows
        s2(i) = cellstr([index1, int2str(i)]);
    end

    MatrixStr = cell(size(Matrix));
    for i=1:cols
    MatrixStr(:,i) = cellstr(num2str(Matrix(:,i),'%10.3f'));
    end
    MatrixStrhelp= [s2';MatrixStr'];
    MatrixOutput = [s1';MatrixStrhelp'];

    fid=fopen(filename,'wt');
    x=MatrixOutput;
    [rows,cols]=size(x);
    
    fprintf(fid,MatrixName);
    fprintf(fid,'\n');
    for i=1:rows
        fprintf(fid,'%s\t',x{i,1:end-1});
        fprintf(fid,'%s\n',x{i,end});
    end
    fprintf(fid,';');
    fclose(fid);   
end