2021-1110-02)�Լ�
 - ����Ŭ�翡�� �����ϴ� �̸� �����ϵǾ� ���డ���� ���
 - ���ڿ�, ����, ��¥, ����ȯ, NULLó��, �����Լ� ���� ������
 1. ���ڿ� �Լ�
  1) CONCAT (c1, c2)
   - �־��� ���ڿ� �ڷ� 'c1' �� 'c2' �� �����Ͽ� ���ο� ���ڿ��� ��ȯ
   - ���ڿ� ���տ�����('||')�� ���ϱ�� ���� 
 ��뿹) ȸ�����̺��� ������ '�ڿ���'�� ȸ���� ȸ����ȣ, ȸ����, �ֹι�ȣ, �ּҸ� ��ȸ�ϵ� �ֹι�ȣ�� 'XXXXXX-XXXXXXX'
        ��������, �ּҴ� �⺻�ּҿ� ���ּҸ� ' ' �� �����Ͽ� ����Ͻÿ�.
        
        SELECT MEM_ID AS ȸ����ȣ,
                MEM_NAME AS ȸ����,
                CONCAT(MEM_REGNO1,CONCAT('-',MEM_REGNO2)) AS �ֹι�ȣ,
                CONCAT(MEM_ADD1,CONCAT(' ',MEM_ADD2))AS �ּ�
        FROM MEMBER
        WHERE MEM_JOB LIKE '%�ڿ���%';
        
        -- c:���ڿ� n:���� d:��¥��
        
  2) LOWER(c1), UPPER(c1), INITCAP(c1)
   - LOWER(c1) : c1 ���ڿ��� ���Ե� ��� ���ڿ��� �ҹ��ڷ� ��ȯ
   - UPPER(c1) : c1 ���ڿ��� ���Ե� ��� ���ڿ��� �빮�ڷ� ��ȯ
   - INITCAP(c1) : c1 ���ڿ��� ���Ե� �ܾ��� ù ���ڸ� �빮�ڷ� ��ȯ
   
 ��뿹) ȸ����ȣ 'D001' ȸ���� 2005�� 5�� ������ ������ ��ȸ�Ͻÿ�.
        Alias�� ��¥, ��ǰ��ȣ, ���ŷ�
        
        SELECT SUBSTR(CART_NO,1,8) AS ��¥,
                CART_PROD AS ��ǰ��ȣ,
                CART_QTY AS ���ŷ�
        FROM CART
        WHERE CART_NO LIKE ('200505%')
              AND UPPER(CART_MEMBER) = 'D001';
              
        SELECT INITCAP (LOWER(FIRST_NAME)||'.'||LOWER(LAST_NAME))
        FROM HR.EMPLOYEES;
        
 3) LPAD(c1,n[,c2]), RPAD(c1,n[c2])
  - n��ŭ Ȯ���� �������� c1�� ����(LPAD), ������(RPAD)���� �����ϰ� ���� �������� c2�� ä�� ��ȯ
  - c2�� �����Ǹ� ������ ä������.
  
 ��뿹) 
    SELECT LPAD(TO_CHAR(PROD_COST),10,'*'),
           RPAD(TO_CHAR(PROD_COST),10,'*'), 
           LPAD(PROD_NAME,30),
           RPAD(PROD_NAME,30)
    FROM PROD;
        
 4) LTRIM(c1[,c2]),RTRIM(c1[,c2])  -- ���� ������ �����ϱ� ���� ����Ѵ�.
  - �־��� ���ڿ� c1���� ���ʺ��� (LTRIM), �����ʺ���(RTRIM) c2 ���ڿ��� ��ġ�ϴ� �κ��� ����
  - c1 ���� c2�� ã���� �ݵ�� c1�� ù��° ���ڿ����� c2�� �����ؾ���
  - c2 �� �����Ǹ� ������ ã�� ���� 
  - c1 ������ ������ �������� �� �Ѵ�.
  
 ��뿹)
    SELECT LTRIM('PERSIMON APPLE BANANA','ABCDEFGHIJKLMNOPQRSTUVWSYZ'),
           RTRIM('PERSIMON APPLE BANANA','NA'), 
           LTRIM('          PERSIMON APPLE BANANA            ',' PE'),
           RTRIM('          PERSIMON APPLE BANANA            ')
    FROM DUAL;
    
 5) TRIM (c1)
  - ���ڿ� c1�� ���ʰ� �����ʿ� �����ϴ� ������ ����
  - ���ڿ� ������ �������Ŵ� �Ұ���
  
 ��뿹)
    SELECT TRIM('      PERSION APPLE BANANA          ')
    FROM DUAL;
    
 ��뿹) ������̺��� EMP_NAME �÷��� ������ Ÿ���� �������� ���ڿ��� �����Ͻÿ�
 
    ALTER TABLE HR.EMPLOYEES
        MODIFY(EMP_NAME CHAR(80));
        
      ALTER TABLE HR.EMPLOYEES
        MODIFY(EMP_NAME VARCHAR2(80));
        
        UPDATE HR.EMPLOYEES
            SET EMP_NAME = TRIM(EMP_NAME);
        COMMIT;
        
        SELECT EMP_NAME 
        FROM HR.EMPLOYEES;
        
 6) SUBSTR(c, sindex[, cnt])
  - �־��� ���ڿ� c���� sindex ��ġ ���� cnt���� ��ŭ�� ���ڿ��� �����Ͽ� ��ȯ��
  - ������ġ�� 1���� ���۵�
  - cnt �� �����Ǹ� sindex ���� ������ ��� ���ڿ� ��ȯ
  - sindex �� ���� ������ ���ڿ� c�� �����ʺ��� ó���Ѵ�.
  
 ��뿹) 
    SELECT SUBSTR('ILPOSTINO BOYHOOD' , 2, 5),
           SUBSTR('ILPOSTINO BOYHOOD' , 2),
           SUBSTR('ILPOSTINO BOYHOOD' , -12, 5)
    FROM DUAL;
    
 ��뿹) ��ٱ��� ���̺��� 2005�� 4���� 6���� �Ǹŵ� ��ǰ�� �Ǹ����踦 ��ȸ�Ͻÿ�.
        Alias�� ��ǰ�ڵ�, �Ǹż���, �Ǹűݾ�
        
        SELECT A.CART_PROD AS ��ǰ�ڵ�,
                SUM(A.CART_QTY) AS �Ǹż���,
                SUM(A.CART_QTY*B.PROD_PRICE) AS �Ǹűݾ�
        FROM CART A, PROD B
        WHERE A.CART_PROD = B.PROD_ID
        -- AND A.CART_NO LIKE '200504%' OR A.CART_NO LIKE '200506%'
        -- AND ( SUBSTR(A.CART_NO,1,6) = '200504' OR SUBSTR(A.CART_NO,1,6) = '200506')
        -- SUBSTR(A.CART_NO,1,6) IN ('200504','200506')
        GROUP BY A.CART_PROD;
        
        
        A.CART_NO LIKE '200504%'; --AND A.CART_NO LIKE ('200506%');
        
        --�ΰ� �̻��� ���̺��� ���ȴٸ�, �ݵ�� WHERE ������ ���� ������ �����ؾ��Ѵ�.
        
 7)REPLACE(c1, c2[,c3]) -- �ܾ� �ȿ� �ִ� ������ �����ϴ� �Լ�
  - �־��� ���ڿ� c1���� c2���ڿ��� ã�� c3���ڿ��� ġȯ
  - c3�� �����ϸ� c2�� ã�� ���� ��
        
 ��뿹) 
        SELECT REPLACE('PERSIOM APPLE BANANA', 'A', 'M'),
               REPLACE('PERSIOM APPLE BANANA', 'A'),
               REPLACE('PERSIOM APPLE BANANA', ' ')
        FROM DUAL;
        
        ===============================================
        SELECT DEPARTMENT_ID AS �μ��ڵ�,
                ROUND(AVG(SALARY)) AS ��ձ޿�
        FROM HR.EMPLOYEES 
        GROUP BY DEPARTMENT_ID
        ORDER BY 1;
        