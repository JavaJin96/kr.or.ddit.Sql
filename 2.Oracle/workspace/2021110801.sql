2021-1108-01)

 (3) �� ������
  - �������� ������� ����
  - NOT, AND, OR ����
  -- ���� ������� ����
  -- NOT�� ���� ������
  
  -----------------------------------------
  �Է�(A)   �Է�(B)  AND    OR    EX-OR
  -----------------------------------------
  0        0        0       0       0   
  0        1        0       1       1
  1        0        0       1       1
  1        1        1       1       0
  -----------------------------------------
  ** 0 : False, 1 : True
  
  -- '-'�� ǥ���ϴ� ����� '����' �̴�.
  -- EX-OR : ���� ���� ������ 0 / �ٸ� ���� ������ 1
  -- OR : ���� ��
  
  
��뿹) ������̺�(HR.EMPLOYEES)���� 60�� �μ� �Ǵ� 80�� �μ� �Ǵ� 100�� �μ��� ���� ����� �����ȣ, �����, �μ���ȣ, �Ի����� ��ȸ�Ͻÿ�.
    
    (OR ������)
    SELECT  EMPLOYEE_ID AS �����ȣ,
            FIRST_NAME || ' ' || LAST_NAME AS �����,
            DEPARTMENT_ID AS �μ���ȣ,
            HIRE_DATE AS �Ի���
    FROM HR.EMPLOYEES
    WHERE DEPARTMENT_ID = 60 OR DEPARTMENT_ID = 80 OR DEPARTMENT_ID = 100
    ORDER BY 3, 4;
    
    (IN ������)
    SELECT  EMPLOYEE_ID AS �����ȣ,
            FIRST_NAME || ' ' || LAST_NAME AS �����,
            DEPARTMENT_ID AS �μ���ȣ,
            HIRE_DATE AS �Ի���
    FROM HR.EMPLOYEES
    WHERE DEPARTMENT_ID IN(60,80,100)       --IN() ��ȣ�ȿ� ������ �Ǹ� ������ ���
    -- WHERE DEPARTMENT_ID ANY(60,80,100)
    -- WHERE DEPARTMENT_ID SOME(60,80,100)
    ORDER BY 3, 4;
    
    (AND ������)
    
 ��뿹1)
    ȸ�����̺��� �������� �����̸鼭 �����̰� ���ϸ����� 3000 �̻��� ȸ���� ��ȸ�Ͻÿ�.
    Alias�� ȸ����ȣ, ȸ����, �ּ�, �ֹι�ȣ, ���ϸ����̴�.
    
    SELECT MEM_ID AS ȸ����ȣ,
            MEM_NAME AS ȸ����,
            MEM_ADD1 || ' ' || MEM_ADD2 AS �ּ�,
            MEM_REGNO1 || '-' || MEM_REGNO2 AS �ֹι�ȣ,
            MEM_MILEAGE AS ���ϸ���
    
    FROM MEMBER
    WHERE SUBSTR(MEM_ADD1,1,2) = '����' AND   -- MEM_ADD1 LIKE '����%'
          ( SUBSTR(MEM_REGNO2,1,1) = '2' OR SUBSTR(MEM_REGNO2,1,1)  = '4' )AND
           MEM_MILEAGE >= 3000
    
    

 ��뿹2)    
    ��ǰ���̺�(PROD)���� �ǸŰ�(PROD_PRICE)�� 20�������� ��ǰ������ ��ȸ�Ͻÿ�.
    Alias�� ��ǰ�ڵ�(PROD_ID), ��ǰ��(PROD_NAME), �ǸŰ�(PROD_PRICE),�Ǹ�����(�ǸŰ�-���԰�)
    
    SELECT PROD_ID AS ��ǰ�ڵ�,
            PROD_NAME AS ��ǰ��,
            PROD_PRICE AS �ǸŰ�,
            PROD_PRICE - PROD_COST AS �Ǹ�����
            
    FROM PROD
    WHERE PROD_PRICE  >= 200000 AND PROD_PRICE < 300000
    ORDER BY 4 DESC;
      
 ��뿹3) ��ǰ���̺�(PROD)����'P300' �з��� ���� ��ǰ������ ��ȸ�Ͻÿ�.
    Alias�� ��ǰ�ڵ�, ��ǰ��, ���԰ŷ�ó�ڵ�(PROD_BUYER), �з��ڵ�(PROD_LGU) 
    
    SELECT PROD_ID AS ��ǰ�ڵ�,
            PROD_NAME AS ��ǰ��,
            PROD_BUYER AS ���԰ŷ�ó�ڵ�,
            PROD_LGU AS �з��ڵ�
    FROM PROD
    WHERE PROD_LGU >= 'P300' AND PROD_LGU < 'P400'
    ORDER BY 1;
    -- SUBSTR(PROD_LGU,2)>= 300 AND SUBSTR(PROD_LGU,2) < 400;
    
 4)��Ÿ������
 (1)'||' 
  - ���ڿ� ���� ������
  (�������)
   expr || expr[expr ....]
   . 'expr' �� ǥ���� ���ڿ� �ڷḦ �����Ͽ� ���ο� ���ڿ� �ڷḦ ��ȯ
   . ���ڿ� �Լ� CONCAT()�� ġȯ ����
   
 ��뿹) ȸ�����̺��� ������ '�ֺ�'�� ȸ�� ������ ��ȸ�Ͻÿ�.
        Alias�� ȸ����ȣ, ȸ����, �ֹε�Ϲ�ȣ, �ּ��̸� �ֹε�Ϲ�ȣ�� 'XXXXXX-XXXXXXX'��������, 
        �ּҴ� �⺻�ּҿ� ���ּҸ�' '�� �����Ͽ� ����Ͻÿ�.
        
    SELECT MEM_ID AS ȸ����ȣ,
            MEM_NAME AS ȸ����,
            MEM_REGNO1 ||'-'|| MEM_REGNO2 AS �ֹε�Ϲ�ȣ,
            CONCAT(CONCAT(MEM_ADD1,' '),MEM_ADD2) AS �ּ�
            --MEM_ADD1 ||' '|| MEM_ADD2 AS �ּ�
    FROM MEMBER
    WHERE SUBSTR(MEM_JOB,1,2) = '�ֺ�'
    -- WHERE MON_JOB = '�ֺ�';
    ORDER BY 2;
    
** ALTER ���
 - DDL(Data Definition Language) ���
 - ���̺��̸� ����, �÷��߰�/����/����, ���̺� ��������� �߰�/����/���� ��� ����
 
 
 (1) ���̺�� ����
  (�������)
  ALTER TABLE ���̺��_OLD RENAME TO ���̺��_NEW;
  .'���̺��_OLD'�� '���̺��_NEW'�� ����
  
 ��뿹) CREATE TABLE TEMP AS
        SELECT * FROM PROD;
        
        ALTER TABLE TEMP RENAME TO T_PROD
        
        SELECT * FROM T_PROD;
        
  (2) �÷�����
   (�������)
    ALTER TABLE ���̺�� RENAME COLUMN �÷���_ORD TO �÷���_NEW;
    .'���̺��'�� �����ϴ� '�÷���_ORD' �� '�÷���_NEW' �� ����
    
 ��뿹) T_PROD ���̺��� PROD_LGU �÷����� LPROD_GU �� �����Ͻÿ�
    ALTER TABLE T_PROD RENAME COLUMN PROD_LGU TO LPROD_GU;
    
    SELECT * FROM T_PROD;
    
  (3) �÷��߰�
  (�������)
  ALTER TABLE ���̺�� ADD (�÷��� ������Ÿ��[ũ��]);
  . '���̺��' �� '�÷���'�� �߰�
  
 ��뿹) ������̺� VARCHAR2(80) �� ���̸� ���� EMP_NAME �÷����� �߰��Ͻÿ�.
    ALTER TABLE HR.EMPLOYEES ADD (EMP_NAME VARCHAR2(80));
    
 ��뿹) ������̺��� �̸� (FIRST_NAME�� LAST_NAME)�� �����Ͽ� EMP_NAME �÷��� �����Ͻÿ�.
    
    UPDATE HR.EMPLOYEES 
        SET EMP_NAME = FIRST_NAME ||' '||LAST_NAME;
    
    SELECT EMP_NAME
    FROM HR.EMPLOYEES;
    
    COMMIT;
    
 (4) �÷�����
 (�������)
 ALTER TABLE ���̺�� DROP COLUMN �÷���;
  .'���̺��' ���̺� ���� '�÷���'�� �ش��ϴ� �÷� ����
  
 ��뿹) ���̺� T_PROD �� �����ϴ� �÷� PROD_IMG�� �����Ͻÿ�.
    ALTER TABLE T_PROD ADD (PROD_IMG VARCHAR2(80));
    ALTER TABLE T_PROD DROP COLUMN PROD_IMG;
    
 (5) �÷�����
 (�������)
 ALTER TABLE ���̺�� MODIFY(�÷��� ������Ÿ��(ũ��));
  . '���̺��' ���̺� ���� '�÷���' �� �ش��ϴ� �÷��� �ڷ���(������Ÿ��)�� ũ�⸦ �����ų�� ����.
  
 ��뿹) 
 ALTER TABLE T_PROD MODIFY(PROD_MILEAGE VARCHAR2(20));
 ALTER TABLE T_PROD MODIFY(PROD_TOTALSTOCK NUMBER(15));
 COMMIT;
 ALTER TABLE T_PROD MODIFY(PROD_TOTALSTOCK NUMBER(9));
    
    
    
        
    
   
    
    
    
    
    