2021-1124-02) 
  3) �񵿵�����(Non Eqi - Join)
   - �������ǿ� '=' ������ �̿��� �����ڰ� ���� ���
   - ������̺��� � ���� �������̺��� ���� ���� ������ ���
   
 ��뿹) ������̺��� �޿��� ��ձ޿����� ���� ����� �����ȣ, �����, �޿�, �μ��ڵ�, ��ձ޿��� ��ȸ�Ͻÿ�.
        
        SELECT  EMPLOYEE_ID AS �����ȣ,
                EMP_NAME AS �����,
                SALARY AS �޿�,
                DEPARTMENT_ID AS �μ��ڵ�,
                B.ASAL AS ��ձ޿�
          FROM  HR.EMPLOYEES A, (SELECT ROUND(AVG(SALARY)) AS ASAL
                                FROM HR.EMPLOYEES) B
         WHERE A.SALARY>B.ASAL
         
         
  4) ��������(Self - Join)
   - �ϳ��� ���̺� ���� �ٸ� ��Ī�� �ο��Ͽ� ���� �ٸ� ���̺�� ����ϸ鼭 �����ϴ� ����.
   
 ��뿹) ȸ����ȣ 'b001' ȸ���� ���ϸ������� ���� ���ϸ����� ������ ȸ���� ȸ����ȣ, ȸ����, ����, ���ϸ����� ��ȸ�Ͻÿ�.
 
        SELECT  A.MEM_ID AS ȸ����ȣ,
                A.MEM_NAME AS ȸ����,
                A.MEM_JOB AS ����,
                A.MEM_MILEAGE AS ���ϸ���,
                B.MEM_MILEAGE AS ���ظ��ϸ���
          FROM  MEMBER A, MEMBER B
         WHERE B.MEM_ID='b001' 
           AND A.MEM_MILEAGE > B.MEM_MILEAGE
        ORDER BY 4;
 
 ��뿹) ������� �޿��� �ڽ��� ���� �μ��� ��ձ޿����� ���� ������� �����ȣ, �����, �μ���ȣ, �޿�, �μ�����ձ޿��� ��ȸ�Ͻÿ�.
 
        SELECT A.EMPLOYEE_ID AS �����ȣ,
               A.EMP_NAME AS �����,
               B.DEPARTMENT_ID AS �μ���ȣ,
               A.SALARY AS �޿�,
               ROUND(AVG(B.SALARY)) AS �μ�����ձ޿�
          FROM HR.EMPLOYEES A, HR.EMPLOYEES B
          WHERE A.SALARY > B.SALARY
         GROUP BY B.DEPARTMENT_ID, A.EMPLOYEE_ID, A.EMP_NAME, A.SALARY
         ORDER BY 3;
         
         
        SELECT A.EMPLOYEE_ID AS �����ȣ,
               A.EMP_NAME AS �����,
               A.DEPARTMENT_ID AS �μ���ȣ,
               A.SALARY AS �޿�, 
               B.SALARY AS �޿�2
          FROM HR.EMPLOYEES A HR.EMPLOYEES B
          WHERE A.SALARY
          
          (SELECT B.DEPARTMENT_ID,
                                   AVG(B.SALARY)
                            FROM HR.EMPLOYEES B
                            GROUP BY B.DEPARTMENT_ID);
         ORDER BY 3;
        
        
        
         SELECT A.EMPLOYEE_ID AS �����ȣ, 
           A.EMP_NAME AS �����, 
           B.DID AS �μ���ȣ, 
           A.SALARY AS �޿�, 
           B.ASAL AS �μ���ձ޿�
         FROM HR.EMPLOYEES A, (SELECT DEPARTMENT_ID) AS DID,
                                   ROUND(AVG(SALARY)) AS ASAL 
                              FROM HR.EMPLOYEES
                             GROUP BY DEPARTMENT_ID
                             ORDER BY 1) B
         WHERE A.DEPARTMENT_ID = B.DID
         AND A.SALARY >= B.ASAL
         ORDER BY 3;
              
              --�μ��� ��ձ޿� 
        SELECT  ROUND(AVG(SALARY)),
                DEPARTMENT_ID
          FROM  HR.EMPLOYEES
          GROUP BY DEPARTMENT_ID
          ORDER BY 2;
               
               
               
               
               
               
               
               
 ��뿹) ������ '�ڿ���' �� ȸ������ ������ ������ ���ϸ������� ���� ���ϸ����� ������ �ִ� ȸ���� ȸ����ȣ, ȸ����, ���� , ���ϸ����� ��ȸ�Ͻÿ�. 
 
        SELECT  A.MEM_ID AS ȸ����ȣ,
                A.MEM_NAME AS ȸ����,
                A.MEM_JOB AS ����,
                A.MEM_MILEAGE AS ���ϸ���
          FROM  MEMBER A
         WHERE  A.MEM_MILEAGE >ANY (SELECT MEM_MILEAGE
                                   FROM MEMBER
                                  WHERE MEM_JOB = '�ڿ���');
                
 ��뿹) ������ '�ڿ���' �� ȸ������ ������ ��� ���ϸ������� ���� ���ϸ����� ������ �ִ� ȸ���� ȸ����ȣ, ȸ����, ���� , ���ϸ����� ��ȸ�Ͻÿ�. 
                
 
     SELECT  A.MEM_ID AS ȸ����ȣ,
                A.MEM_NAME AS ȸ����,
                A.MEM_JOB AS ����,
                A.MEM_MILEAGE AS ���ϸ���
          FROM  MEMBER A
         WHERE  A.MEM_MILEAGE >ALL (SELECT MEM_MILEAGE
                                   FROM MEMBER
                                  WHERE MEM_JOB = '�ڿ���');
 
 
 
 