2021-1118-02) NULLó���Լ�
 - ����Ŭ�� ��� �ڷ�Ÿ���� �ڷᰡ �Էµ��� ���� ��� �⺻���� NULL�� ����(NOT NULL ���� ������ �ο��� ��� ����)
 - NULL���� ����� ��� ����� NULL��
 - �̸� �ذ��ϱ� ���� �Լ��� NVL, NVL2, NULLIF ���� ������
 
 1) NULL ���θ� �Ǵ��ϴ� ������ 
  . IS NULL, IS NOT NULL�� ����ؾ� �Ѵ�.(=NULL, !=NULL�� ������ �ƴϳ� ������ ��������)
  
 ��뿹) ������̺��� ���������ڵ�(COMMISSION_PCT)�� NULL�� �ƴ� ��������� ��ȸ�Ͻÿ�.
        Alias�� �����ȣ, �����, �μ��ڵ�, ���������ڵ�
        
        SELECT EMPLOYEE_ID, EMP_NAME, COMMISSION_PCT, DEPARTMENT_ID
        FROM HR.EMPLOYEES
        --WHERE COMMISSION_PCT != NULL;
        WHERE COMMISSION_PCT IS NOT NULL;
        
 2) NVL(col,val)
  . 'col' ���� �Ǵ��Ͽ� �� ���� NULL �̸� 'VAL' ���� ��ȯ�ϰ�, NULL�� �ƴϸ� 'col'���� ��ȯ
  . 'col' �� 'val'�� �ݵ�� ���� ������ Ÿ���̾�� ��
  . �ܺ����ο����� ���� 
  
 ��뿹) ������̺��� ���������� ���� ���ʽ��� ����ϰ�, �޿��� ���޾��� ����Ͽ� �����Ϸ��Ѵ�. ���޸����� ����Ͻÿ�.
        ���ʽ� = �޿� * ���������ڵ�
        ���޾� = �޿� + ���ʽ�
        ����� �����ȣ, �����, �μ��ڵ�, ���������ڵ�, �޿�, ���ʽ�, ���޾�
        
            SELECT  EMPLOYEE_ID AS �����ȣ,
                    EMP_NAME AS �����,
                    DEPARTMENT_ID AS �μ��ڵ�,
                    NVL(COMMISSION_PCT,0) AS ���������ڵ�,
                    SALARY AS �޿�,
                    NVL(SALARY * COMMISSION_PCT,0) AS ���ʽ�,
                    SALARY +  NVL(SALARY * COMMISSION_PCT,0)AS ���޾�
            FROM HR.EMPLOYEES
            ORDER BY 3;
        
 ��뿹) ��ǰ���̺��� �з��ڵ尡 'P101' ~ 'P202' �� ���ϴ� ��ǰ�� ���ϸ���(PROD_MILEAGE) �÷� ���� �ǸŰ����� 0.05%�� �����Ͻÿ�.
        
            UPDATE PROD
            SET PROD_MILEAGE=ROUND(PROD_PRICE * 0.0005)
            WHERE PROD_LGU>='P101' AND PROD_LGU<='P202'
        
            COMMIT;
            
 ��뿹) ��ǰ���̺��� ��ǰ�� ���� ���ϸ����� ��ȸ�ϵ�, �� ���� NULL�̸� '���ϸ����� �ο����� ���� ��ǰ' �̶�� �޽����� ���ϸ��� ��� ����Ͻÿ�.
        Alias �� ��ǰ�ڵ�, ��ǰ��, �ǸŰ���, ���ϸ����̴�.
        
         SELECT PROD_ID AS ��ǰ�ڵ�,
                PROD_NAME AS ��ǰ��,
                PROD_PRICE AS �ǸŰ���,
                NVL(LPAD(TO_CHAR(PROD_MILEAGE),10,' '), '���ϸ����� �ο����� ���� ��ǰ') AS ���ϸ���
                --LPAD ,RPAD ����(������) �����̳� ���ڿ� ���� �Լ�
         FROM PROD
         
 ��뿹) ��� �з��� ��ǰ�� ���� ��ȸ�Ͻÿ�.
        Alias�� �з��ڵ�, �з���, ��ǰ�Ǽ�
        --LPROD_GU : LPROD ���̺��� �⺻Ű (�з��ڵ�)
        --LPROD_NM : �з���
        
        --������ ���� ���� ���� ��.(�ڷ��� ���� �߿����� ����)
        
        SELECT  A.LPROD_GU AS �з��ڵ�,
                A.LPROD_NM AS �з���,
                COUNT(B.PROD_ID) AS ��ǰ�Ǽ�
        FROM  LPROD A, PROD B
        WHERE A.LPROD_GU = B.PROD_LGU(+)  --�ڷ��� ���� �����ʿ� (+)�� ���ָ� �ܺ������� �ȴ�. / �ڷ��� ���� �������� ���� ���,
        GROUP BY A.LPROD_GU, A.LPROD_NM
        ORDER BY 1;
        
 ��뿹) ��� �з��� ��ǰ�� ���ϸ��� �հ踦 ��ȸ�Ͻÿ�.
        Alias�� �з��ڵ�, ��ǰ�� ��, ���ϸ��� �հ�
        
        SELECT  A.LPROD_GU AS �з��ڵ�,
                A.LPROD_NM AS �з���,
                COUNT(B.PROD_ID) AS ��ǰ�Ǽ�,
                NVL(SUM(B.PROD_MILEAGE),0) AS ���ϸ����հ�
        FROM  LPROD A, PROD B
        WHERE A.LPROD_GU = B.PROD_LGU(+)  --�ڷ��� ���� �����ʿ� (+)�� ���ָ� �ܺ������� �ȴ�.
        GROUP BY A.LPROD_GU, A.LPROD_NM
        ORDER BY 1;
                
         
 3) NVL2(col,val1,val2)
  . 'col' �� ���� NULL�̸� val2���� NULL�� �ƴϸ�, vall ���� ��ȯ
  . val1 �� val2�� ������ Ÿ���� ��ġ�ؾ���
  . NVL�� Ȯ���� ����
  
 ��뿹) ��ǰ���̺��� ��ǰ�� ũ�Ⱑ NULL�̸� 'ũ�Ⱑ ���� ��ǰ' �� NULL�� �ƴϸ� �ش� ��ǰ ũ�⸦ ����� ����Ͻÿ�.
        Alias�� ��ǰ�ڵ�, ��ǰ��, ũ��, ���
        
        SELECT  PROD_ID AS ��ǰ�ڵ�,
                PROD_NAME AS ��ǰ��,
                NVL2(PROD_SIZE, PROD_SIZE,'ũ�Ⱑ ���� ��ǰ') AS ���,
                NVL(PROD_SIZE,'ũ�Ⱑ ���� ��ǰ') AS ���2
        FROM PROD
        
         
 4) NULLIF(c1, c2)
  . 'c1' �� 'c2' �� ���� ���� ������ NULL �� ��ȯ�ϰ�, ���� �ٸ� ���̸� c1���� ��ȯ
  
** PROD ���̺��� �з��ڵ� 'P102' �� ���� ��ǰ���� �����ǸŰ����� ��ǰ�� ���԰��� �����Ͻÿ�.

    UPDATE PROD
    SET PROD_SALE=PROD_COST
    WHERE PROD_LGU = 'P102';
    
    COMMIT
     
    SELECT PROD_COST, PROD_PRICE, PROD_SALE
    FROM PROD
    WHERE PROD_LGU = 'P102';
         
 ��뿹) ��ǰ���̺��� ���԰��� ���ΰ��� ������ ��ǰ�� ����� '����������ǰ', �������� ���� ��ǰ�� '�����ǰ' �� ����Ͻÿ�.
        Alias�� ��ǰ�ڵ�, ��ǰ��, ���԰���, ���Ⱑ��, ���ΰ���, ����̴�.
        
        SELECT  PROD_ID AS ��ǰ�ڵ�,
                PROD_NAME AS ��ǰ��,
                PROD_COST AS ���԰���,
                PROD_PRICE AS ���Ⱑ��,
                PROD_SALE AS ���ΰ���,
                NVL2 (NULLIF (TO_CHAR(PROD_COST),TO_CHAR(PROD_SALE)), '�����ǰ', '����������ǰ') AS ���
        FROM PROD
    
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         




