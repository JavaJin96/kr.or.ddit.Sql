2021-1125-01)��������

 - ���� �ȿ� �� �ٸ� ������ ����
 - ���������� ���� JOIN ���� ����� �� ����
 - ���������� ������(��������)���� ����� �߰������ �����ϱ� ���� ����
 - ���������� '(_)' �ȿ� �����
 - ���������� ������ �����ʿ� ��ġ�ؾ� ��
  (���������� �з�)
  . �Ϲݼ������� : SELECT���� ��ġ
  . �ζ���(in-line) �������� : FROM ���� ��ġ(���������� ����) -- ������� ����Ǳ� ������ ���������� �����ؾ� �Ѵ�.
  . ��ø�������� : WHERE���� ��ġ
 - ������������ ������ ���ο� ����
  . �������� ���� �������� : ���������� ���� ���̺�� ���������� ���� ���̺� ���̿� JOIN�� �߻� ���� �ʴ� ����
  . �������� �ִ� �������� : ���������� ���� ���̺�� ���������� ���� ���̺� ���̿� JOIN ���� ����� ����
 - ��ȯ�Ǵ� ���� ������ ����
  . ������ �������� : �ϳ��� �ุ ��ȯ(�Ϲ� ������ ���)
  . ������ �������� : �������� ���� ��ȯ(������ �����ڸ� ����Ͽ� ó��)
  
  
  1. ���������� ��������
   - ���������� �������� ���̿� �������� ������� ���� ��������
   
   
 ��뿹) ������̺��� ��ձ޿����� ���� �޿��� �޴� ����� �����ȣ, �����, �μ���ȣ, �޿��� ����Ͻÿ�.
       
        (�������� : Alias (�����ȣ, �����, �μ���ȣ, �޿�))  
        SELECT  EMPLOYEE_ID AS �����ȣ,
                EMP_NAME AS �����,
                DEPARTMENT_ID AS �μ���ȣ,
                SALARY AS �޿�
          FROM HR.EMPLOYEES
         WHERE A.SALARY >
         
        (�������� : ��ձ޿� ���)
        SELECT ROUND(AVG(SALARY))
          FROM HR.EMPLOYEES
           
        (����) - ��� ����� ��ŭ WHERE ���� �����Ѵ�.
        SELECT  EMPLOYEE_ID AS �����ȣ,
                EMP_NAME AS �����,
                DEPARTMENT_ID AS �μ���ȣ,
                SALARY AS �޿�
          FROM HR.EMPLOYEES
         WHERE SALARY > (SELECT ROUND(AVG(SALARY))
                             FROM HR.EMPLOYEES);
                             
                             
        (����)  - ���������� �ϸ鼭 ���ü� �ִ� ���������� �Ǿ���. 
               - ���� AS SAVG��� ��Ī�� �ο��Ͽ� ��Ī�� SALARY �� ���ϰ� �ȴ�. (�������� ��ü�� ����Ǹ鼭 �񱳵Ǵ� ���� �ƴ�, ��Ī�� �Ҵ�� ������ �񱳸� �ϰ� �ȴ�.)
        SELECT  A.EMPLOYEE_ID AS �����ȣ,
                A.EMP_NAME AS �����,
                A.DEPARTMENT_ID AS �μ���ȣ,
                A.SALARY AS �޿�
          FROM HR.EMPLOYEES A, (SELECT ROUND(AVG(SALARY)) AS SAVG
                                FROM HR.EMPLOYEES) B
         WHERE SALARY > B.SAVG;                     
        
        
  2) �������� �ִ� ��������
   - ���������� �������� ���̿� �������� ����� ��������
   
 ��뿹) �����������̺��� ���� �μ���ȣ�� �μ����̺��� �μ���ȣ�� ���� ������ ��ȸ�Ͻÿ�.
        Alias�� �μ���ȣ, �μ���
        
        (��������)
        SELECT  DEPARTMENT_ID AS �μ���ȣ,
                DEPARTMENT_NAME AS �μ���
          FROM  HR.DEPARTMENTS 
         WHERE  DEPARTMENT_ID = 
        
        
        (�������� : �μ����̺��� �μ���ȣ�� ������ �����������̺��� �μ���ȣ)
        SELECT B.DEPARTMENT_ID
          FROM HR.DEPARTMENTS A, HR.JOB_HISTORY B
         WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
         
        (���� : EXISTS ������ Ȱ��)
        SELECT  A.DEPARTMENT_ID AS �μ���ȣ,
                A.DEPARTMENT_NAME AS �μ���
          FROM  HR.DEPARTMENTS A 
         WHERE  EXISTS (SELECT 1
                          FROM HR.JOB_HISTORY B
                         WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID);              
        -- EXISTS ���������� �ϳ��� ���̶� �����ϸ� ���̵ȴ�. 
        -- SELECT ���� 1�� �ƹ� �ǹ̰� ���� �����̴�.(��ȯ�Ǵ� ���� �ִ��� ������ �Ǵ��ϱ� ���ؼ�)
        -- ���� �ܼ��� ���Ǹ� ������ ���������� 1�� ���, ��°��� �����ϱ� ������ EXISTS �� ���� �ȴ�.
        
        (���� : IN ������ Ȱ��)
        SELECT  A.DEPARTMENT_ID AS �μ���ȣ,
                A.DEPARTMENT_NAME AS �μ���
          FROM  HR.DEPARTMENTS A 
         WHERE  A.DEPARTMENT_ID IN (SELECT B.DEPARTMENT_ID
                                      FROM HR.JOB_HISTORY B);
                                      
        
        SELECT  /*EMPLOYEE_ID AS �����ȣ, 
                (SELECT EMP_NAME
                   FROM HR.EMPLOYEES A
                  WHERE A.EMPLOYEE_ID = B.EMPLOYEE_ID) AS �����, */
                DISTINCT B.DEPARTMENT_ID AS �μ���ȣ,
                (SELECT DEPARTMENT_NAME 
                   FROM HR.DEPARTMENTS C
                  WHERE C.DEPARTMENT_ID = B.DEPARTMENT_ID) AS �μ���
          FROM  HR.JOB_HISTORY B;
        
        
 ��뿹) 2005�� 5�� ���űݾ��� �������� ���� ���� ���Ÿ� ����� ȸ���� ȸ����ȣ, ȸ����, ����, ���ϸ����� ��ȸ�Ͻÿ�.
        
        SELECT  A.MEM_ID AS ȸ����ȣ,
                A.MEM_NAME AS ȸ����,
                A.MEM_JOB AS ����,
                A.MEM_MILEAGE AS ���ϸ���
          FROM  MEMBER A
         WHERE  A.MEM_ID = (  SELECT  D.DID
                                FROM  (SELECT  SUM(B.CART_QTY * C.PROD_PRICE) AS DSUM,
                                               B.CART_MEMBER AS DID
                                         FROM CART B, PROD C
                                        WHERE B.CART_PROD = C.PROD_ID
                                          AND B.CART_NO LIKE '200505%'
                                         GROUP BY B.CART_MEMBER
                                         ORDER BY 1 DESC )D,
                                         MEMBER A
                               WHERE  ROWNUM = 1);       
                  
        (��������)                      
        SELECT  D.DID
          FROM  (SELECT  SUM(B.CART_QTY * C.PROD_PRICE) AS DSUM,
                         B.CART_MEMBER AS DID
                   FROM CART B, PROD C
                  WHERE B.CART_PROD = C.PROD_ID
                    AND B.CART_NO LIKE '200505%'
               GROUP BY B.CART_MEMBER
               ORDER BY 1 DESC )D,
               MEMBER A
         WHERE  ROWNUM = 1;
         
         
         
         
        (�������� ó���ϱ� ����)
        SELECT  D.DID
          FROM  (SELECT  SUM(B.CART_QTY * C.PROD_PRICE) AS DSUM,
                         B.CART_MEMBER AS DID
                   FROM CART B, PROD C
                  WHERE B.CART_PROD = C.PROD_ID
                    AND B.CART_NO LIKE '200505%'
               GROUP BY B.CART_MEMBER
               ORDER BY 1 DESC )D,
               MEMBER A
         WHERE  ROWNUM = 1;
          
       
** ���� ������ �����ϴ� ���������̺��� �����Ͻÿ�.
    1) ���̺�� : REMAIN
    2) �÷� �� ��������
    ------------------------------------------------------------------------------
     �÷���        ������Ÿ��           NULLABLE    DEFAULT         PK/FK
    ------------------------------------------------------------------------------
    REMAIN_YEAR   CHAR(4)               N.N                        PK
    PROD_ID       VARCHAR2(10 BYTE)     N.N                        PK/FK
    REMAIN_J_00   NUMBER(5)                         0                                --�������
    REMAIN_I      NUMBER(5)                         0                                --�԰����
    REMAIN_O      NUMBER(5)                         0                                --������   
    REMAIN_J_99   NUMBER(5)                         0                                --�⸻���(����+�԰�-���)
    REMAIN_DATE   DATE
    ------------------------------------------------------------------------------
    
    CREATE TABLE REMAIN(
        REMAIN_YEAR   CHAR(4),
        PROD_ID       VARCHAR2(10 BYTE),
        REMAIN_J_00   NUMBER(5) DEFAULT 0,
        REMAIN_I      NUMBER(5) DEFAULT 0,
        REMAIN_O      NUMBER(5) DEFAULT 0,
        REMAIN_J_99   NUMBER(5) DEFAULT 0,
        REMAIN_DATE   DATE,
        
        CONSTRAINT pk_remain PRIMARY KEY(REMAIN_YEAR,PROD_ID ),
        CONSTRAINT fk_re_prod FOREIGN KEY(PROD_ID) REFERENCES PROD(PROD_ID));
        
** ������ ���������̺� ���� �ڷḦ �Է��Ͻÿ�.
    REMAIN_YEAR : '2005'
    PROD_ID : ��ǰ���̺��� ��ǰ�ڵ�
    
    INSERT INTO REMAIN (REMAIN_YEAR,PROD_ID)
    --VALUES() : �ϳ��� �Է��� ��,
    --���������� �̿��� �ϰ�ó���� �Ҷ��� VALUES()�� ����
    SELECT '2005', PROD_ID FROM PROD;
        
    SELECT * FROM REMAIN;
    
** ������ ���������̺� �������� ��¥�� �Է��Ͻÿ�.
   �������� ��ǰ���̺��� ������� ����ϰ�, ��¥�� 2004-12-31�� �Է�
   
   UPDATE REMAIN A
      SET (A.REMAIN_J_00, A.REMAIN_J_99, A.REMAIN_DATE) =
      (SELECT B.PROD_PROPERSTOCK,
              B.PROD_PROPERSTOCK,       
              TO_DATE('20041231')
         FROM PROD B
        WHERE A.PROD_ID = B.PROD_ID)
    WHERE A.REMAIN_YEAR = '2005';
         
      SELECT * FROM REMAIN;
      
      COMMIT;
      
      
      
      
      