2021-1129-01)���տ�����  
 -���������� ��ü�� ���ִ� ������
 -UNION, UNION ALL, INTERSECT, MINUS ����
 -���շп��� �����ϴ� ������ db���� �����ϱ� ���� ������. 
 -�� SELECT ���� SELECT ���� ���� Į���� ���� ����, �÷��� ������Ÿ���� ��ġ�ؾ���
 -ù�� ° SELECT ���� SELECT���� ����� �����̵�
 -CLOB,BLOB,BFILE Ÿ���� ��� �Ұ�
 -ORDER BY ���� �� ������ SELECT ������ ��� ����.
  
    1)������ : UNION(�ߺ������� -A n B)
              UNION ALL(�ߺ���� A n B) 
       
        ��뿹) ȸ������ ������ '�л�'�� ȸ�� ���� �Ǵ� ��̰� '���'�� ȸ������ ȸ����, �ּ�,���,������ ��ȸ�Ͻÿ�
       -- ��-SELECT���� �÷��� ����, �÷��� ����, �÷��� ������Ÿ�� ������ ��ġ�ؾ���
       -- ��뷮 Ÿ�� ���Ұ� (CLOB,BLOB,BFILE)
       SELECT MEM_ID AS ȸ����ȣ,
              MEM_NAME AS ȸ����,
              MEM_ADD1||' '||MEM_ADD2 �ּ�,
              MEM_LIKE AS ���,
              MEM_JOB AS ����
         FROM MEMBER
        WHERE MEM_JOB ='�л�'
        
        UNION ALL
        SELECT MEM_ID AS ȸ����ȣ,
              MEM_NAME AS ȸ����,
              MEM_ADD1||' '||MEM_ADD2 �ּ�,
              MEM_LIKE AS ���,
              MEM_JOB AS ����
         FROM MEMBER
        WHERE MEM_LIKE ='���';
        
 ��뿹) 2005�� 4���� 6���� �Ǹŵ� ��� ��ǰ���� ��ȸ�Ͻÿ�.
        Alias�� ��ǰ�ڵ�, ��ǰ��, ���Դܰ�, ����ܰ�
        ��, �ߺ�����
        
        SELECT  DISTINCT A.CART_PROD AS ��ǰ�ڵ�,
                B.PROD_NAME AS ��ǰ��,
                B.PROD_COST AS ���Դܰ�,
                B.PROD_PRICE AS ����ܰ�
          FROM  CART A, PROD B
         WHERE  A.CART_NO LIKE '200504%'
           AND  A.CART_PROD = B.PROD_ID
           
        UNION 
        SELECT  DISTINCT A.CART_PROD AS ��ǰ�ڵ�,
                B.PROD_NAME AS ��ǰ��,
                B.PROD_COST AS ���Դܰ�,
                B.PROD_PRICE AS ����ܰ�
          FROM  CART A, PROD B
         WHERE  A.CART_NO LIKE '200506%'
           AND  A.CART_PROD = B.PROD_ID;
           
        SELECT  DISTINCT A.CART_PROD AS ��ǰ�ڵ�,
                B.PROD_NAME AS ��ǰ��,
                B.PROD_COST AS ���Դܰ�,
                B.PROD_PRICE AS ����ܰ�
          FROM  CART A, PROD B
         WHERE A.CART_NO LIKE '200506%' OR A.CART_NO LIKE '200504%'
           AND A.CART_PROD = B.PROD_ID;
           
        
 ��뿹) 2005�� 6���� ���Ե� ��ǰ��� 2005�� 6�� ����� ��ǰ���� ��ȸ�Ͻÿ�
        Alias�� ��ǰ�ڵ�, ��ǰ��
        
        SELECT  DISTINCT BUY_PROD AS ��ǰ�ڵ�,
                PROD_NAME AS ��ǰ��
          FROM  BUYPROD , PROD 
         WHERE  BUY_DATE BETWEEN TO_DATE('20050601') AND TO_DATE('20050630')
           AND  BUY_PROD = PROD_ID
           
    UNION 
        SELECT  DISTINCT CART_PROD AS ��ǰ�ڵ�,
                PROD_NAME AS ��ǰ��
          FROM  CART, PROD
         WHERE  CART_PROD = PROD_ID
           AND  CART_NO LIKE '200506%'
         ORDER BY 1;
        
        
    2) INTERSECT
     - �������� ����� ��ȯ
     
 ��뿹) 2005�� 1���� 2���� ��� ������ �߻��� ��ǰ�� ��ȸ�Ͻÿ�.
        Alias�� ��ǰ�ڵ�, ��ǰ��, �ŷ�ó�ڵ�
        
        SELECT  B.PROD_ID AS ��ǰ�ڵ�,
                B.PROD_NAME AS ��ǰ��,
                B.PROD_BUYER AS �ŷ�ó�ڵ�
        FROM  BUYPROD A , PROD B
       WHERE  B.PROD_ID = A.BUY_PROD
         AND  A.BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050131')
         
        
        INTERSECT
        SELECT  B.PROD_ID AS ��ǰ�ڵ�,
                B.PROD_NAME AS ��ǰ��,
                B.PROD_BUYER AS �ŷ�ó�ڵ�
          FROM  BUYPROD A , PROD B
         WHERE  B.PROD_ID = A.BUY_PROD
           AND  A.BUY_DATE BETWEEN TO_DATE('20050401') AND LAST_DAY(TO_DATE('20050401'));
           
 ��뿹) 2005�� 1���� 4���� ��� ������ �߻��� ��ǰ �� 5���� �Ǹŵ� ��ǰ�� ��ȸ�Ͻÿ�.
        Alias�� ��ǰ�ڵ�, ��ǰ��, �ŷ�ó�ڵ�
        
        (5���� �Ǹŵ� ��ǰ)
        SELECT  DISTINCT A.CART_PROD AS ��ǰ�ڵ�,
                B.PROD_NAME AS ��ǰ��,
                B.PROD_BUYER AS �ŷ�ó�ڵ�
          FROM  CART A, PROD B
         WHERE  A.CART_NO LIKE '200505%'
           AND  A.CART_PROD = B.PROD_ID;
           
        (����)
        SELECT  B.PROD_ID AS ��ǰ�ڵ�,
                B.PROD_NAME AS ��ǰ��,
                B.PROD_BUYER AS �ŷ�ó�ڵ�
        FROM  BUYPROD A , PROD B
       WHERE  B.PROD_ID = A.BUY_PROD
         AND  A.BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050131')

        INTERSECT
        SELECT  B.PROD_ID AS ��ǰ�ڵ�,
                B.PROD_NAME AS ��ǰ��,
                B.PROD_BUYER AS �ŷ�ó�ڵ�
          FROM  BUYPROD A , PROD B
         WHERE  B.PROD_ID = A.BUY_PROD
           AND  A.BUY_DATE BETWEEN TO_DATE('20050401') AND LAST_DAY(TO_DATE('20050401'))
        
        INTERSECT
         SELECT  DISTINCT A.CART_PROD AS ��ǰ�ڵ�,
                B.PROD_NAME AS ��ǰ��,
                B.PROD_BUYER AS �ŷ�ó�ڵ�
          FROM  CART A, PROD B
         WHERE  A.CART_NO LIKE '200505%'
           AND  A.CART_PROD = B.PROD_ID;
        
        
 ��뿹) 2005�� 1���� 4�� �� 1������ ���Ե� ��ǰ������ ��ȸ�Ͻÿ�
        Alias�� ��ǰ�ڵ�, ��ǰ��, �з��ڵ�
        
        SELECT  DISTINCT B.BUY_PROD AS ��ǰ�ڵ�,
                A.PROD_NAME AS ��ǰ��,
                A.PROD_LGU AS �з��ڵ�
          FROM  PROD A, BUYPROD B
         WHERE  A.PROD_ID = B.BUY_PROD
           AND  B.BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050131')
         
        MINUS  
        SELECT  DISTINCT B.BUY_PROD AS ��ǰ�ڵ�,
                A.PROD_NAME AS ��ǰ��,
                A.PROD_LGU AS �з��ڵ�
          FROM  PROD A, BUYPROD B
         WHERE  A.PROD_ID = B.BUY_PROD
           AND  B.BUY_DATE BETWEEN TO_DATE('20050401') AND TO_DATE('20050430')
        
        
        SELECT  A.PROD_ID,
                A.PROD_NAME,
                A.PROD_LGU
        FROM (SELECT DISTINCT BUY_PROD AS APID
                FROM BUYPROD
                WHERE BUY_DATE BETWEEN TO_DATE('20050101')
                    AND TO_DATE('20050131'))TBLA,
                PROD A
        WHERE TBLA.APID NOT IN (SELECT DISTINCT BUY_PROD AS BPID
                                FROM BUYPROD
                                WHERE BUY_DATE BETWEEN TO_DATE('20050401') AND TO_DATE('20050430'))
        AND A.PROD_ID = TBLA.APID;
        
        
        
        
        
        
