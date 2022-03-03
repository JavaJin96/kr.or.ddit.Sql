2021-1201-04) User Defined Function(�Լ� : Function)
  - ��ȯ ���� �ִ�.
  - PROCEDURE�� ������ ����
  (�������)
    CREATE OR REPLACE FUNCTION �Լ���[(
        �Ű����� [IN|OUT|INOUT] ������Ÿ��[:= �⺻��],
                        .
                        .
        �Ű����� [IN|OUT|INOUT] ������Ÿ��[:= �⺻��]
        
        RETURN ������Ÿ��
    IS|AS
        �����;
    BEGIN
        �����;
        RETURN ��ȯ��;
        [EXCEPTION
            ����ó��;
        ]
    END;
     . 'RETURN ������Ÿ��' : ��ȯ�� �������� Ÿ��
     . 'RETURN ��ȯ��' : ���� ��ȯ ������� �ݵ�� 1�� �̻� ���� �ؾ���
    
 ��뿹) ���� ��ǰ�ڵ带 �Է� �޾� �ش� ���� �Ǹŵ� �ش��ǰ�� �Ǹž��� ��ȯ�ϴ� �Լ�
        
        CREATE OR REPLACE FUNCTION FN_SALES(
            P_MONTH IN VARCHAR2,
            P_CID IN PROD.PROD_ID%TYPE)
            
            RETURN NUMBER
        IS
            V_SUM NUMBER := 0; --�Ǹž�
        BEGIN
            SELECT SUM(A.CART_QTY *B.PROD_PRICE) INTO V_SUM
              FROM CART A, PROD B
             WHERE A.CART_PROD = B.PROD_ID
               AND A.CART_NO LIKE '2005' || P_MONTH ||'%'
               AND A.CART_PROD = P_CID;
            RETURN V_SUM  ;
        END;
    
    
    (����)
        SELECT PROD_ID, PROD_NAME,
               NVL(FN_SALES('06',PROD_ID),0)
          FROM PROD
         ORDER BY 3 DESC;
    
 ��뿹) �з��ڵ带 �Է� �޾� �з��� ��ո��Ծװ� ��ո������ ��ȯ�ϴ� �Լ��� �ۼ��Ͻÿ�.
        
        CREATE OR REPLACE FUNCTION FN_AVG(
            P_LGU IN LPROD.LPROD_GU%TYPE)
            RETURN NUMBER
        IS
            V_AVG_BUY NUMBER := 0;    
        BEGIN
            --��ո��Ծ�
            SELECT ROUND(AVG(BUY_QTY * BUY_COST)) INTO V_AVG_BUY
              FROM BUYPROD , PROD 
             WHERE PROD_LGU = P_LGU
               AND BUY_PROD = PROD_ID;
            RETURN V_AVG_BUY;
            
        END; 
        (����)
         SELECT LPROD_GU,
                LPROD_NM,
                FN_AVG(LPROD_GU)
           FROM LPROD;
           
           
           
           
           
             --��ո����
            SELECT ROUND(AVG(CART_QTY * PROD_PRICE)) INTO P_AVG_SALE
              FROM CART, PROD
             WHERE PROD_LGU = P_LGU
               AND CART_PROD = PROD_ID;
               
            RETURN V_AVG_BUY;
            
        (����)
          SELECT LPROD_GU,
                LPROD_NM,
                FN_AVG(LPROD_GU),
                FN_AVG_SALES(LPROD_GU) 
           FROM LPROD;
           
           
 ��뿹) ��¥�� ȸ����ȣ�� �Է¹޾� ��ٱ��Ϲ�ȣ�� �����Ͻÿ�.
        
        
        CREATE OR REPLACE FUNCTION FN_CREATE_CARTNO(
        P_DATE VARCHAR2,
        P_MID MEMBER.MEM_ID%TYPE)
        RETURN VARCHAR2
      IS
        V_CNT NUMBER:=0; --�ڷ��� ��
        V_CARTNO VARCHAR2(13); --�ӽ���ٱ��Ϲ�ȣ
        V_MEM_ID MEMBER.MEM_ID%TYPE; --������ ��¥�� ����ū ��ٱ��Ϲ�ȣ�� 
                                     --�ο����� ȸ����ȣ
      BEGIN
        SELECT COUNT(*) INTO V_CNT
          FROM CART
         WHERE CART_NO LIKE P_DATE||'%'; 
        
        IF V_CNT != 0 THEN
           SELECT MAX(CART_NO) INTO V_CARTNO
             FROM CART
            WHERE CART_NO LIKE P_DATE||'%';
            
           SELECT DISTINCT CART_MEMBER INTO V_MEM_ID
             FROM CART
            WHERE CART_NO=V_CARTNO; 
        END IF;
        
        IF V_MEM_ID != P_MID THEN
           V_CARTNO:=V_CARTNO+1;
        END IF;
        
        IF V_CNT=0 THEN
           V_CARTNO:=P_DATE||'00001';
        END IF;   
        RETURN V_CARTNO; 
      END;

 (����)
      SELECT FN_CREATE_CARTNO('20050501','b001')
        FROM DUAL;
        
      SELECT FN_CREATE_CARTNO('20050501','c001')
        FROM DUAL;  
      
      SELECT FN_CREATE_CARTNO('20050502','c001')
        FROM DUAL; 



 ��뿹) �μ���ȣ�� �Է¹޾� �μ��� �ο����� ��ȯ�ϴ� �Լ��� �ۼ��ϰ� �μ���ȣ,�μ���,�ο����� ����Ͻÿ�.
        �Լ��� : FN_SUM_EMP
        
        CREATE OR REPLACE FUNCTION FN_SUM_EMP(
            P_DNUM HR.DEPARTMENTS.DEPARTMENT_ID%TYPE)
            RETURN NUMBER
        IS
            V_SUMD NUMBER;
        BEGIN
            SELECT COUNT(DEPARTMENT_ID) INTO V_SUMD
              FROM HR.EMPLOYEES
             WHERE DEPARTMENT_ID = P_DNUM;
        RETURN V_SUMD;
        END;
        
        SELECT DEPARTMENT_ID,
               DEPARTMENT_NAME,
               FN_SUM_EMP(DEPARTMENT_ID)
          FROM HR.DEPARTMENTS;
          
          
    
   













    