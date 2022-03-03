2021-1202-01) Ʈ����(Trigger)
  - Ư�� ���̺��� ����(INSERT,UPDATE,DELETE) �Ǹ� �̸� �̺�Ʈ�� �ٸ� ���̺��� �ڵ����� ����ǵ��� �ϴ� ������ ���ν���

 (�������)
    CREATE OR REPLACE TRIGGER Ʈ���Ÿ�
      AFTER|BEFOR   INSERT|UPDATE|DELETE ON ���̺�� 
      [FOR EACH ROW]  -- �������Ʈ���ſ� �����Ʈ������ ����
      [WHEN ����]
    [DECLARE]
        �����;
    BEGIN
        Ʈ���� ����;
    END;
    
     . 'AFTER|BEFOR' : Ʈ���� �߻� ���� ����  --Ʈ������ ���� ���� BEFOR ���� ���� ���Ĵ� AFTER
     . 'INSERT|UPDATE|DELETE' : �̺�Ʈ(���� ��� ����, OR ������ ���)
     . 'FOR EACH ROW' : Ʈ���� ���� (����� Ʈ����, �����ϸ� ������� Ʈ����)  --Ʈ����:=(������� Ʈ���ſ� ����� Ʈ����)
     -- **���� �߻��� ������ ���������� Ʈ���Ű� �߻���(5���� ��ǰ �Ǹ�..)
     -- **���� ������ �� �ѹ� ����ȴ�(�� ��� x)
     . 'WHEN ����' : ����� Ʈ���ſ����� ��� ����, �̺�Ʈ�߻��� ���� ���� ��ü���� ���� ����
     -- :NEW(���Ӱ� ���� �ڷ�-������ �Ⱦ��� �� CART���̺� ����) �� :OLD(������ �ִ� �ڷ�-���̺��� �ڷḦ ������ ��)
     
1) Ʈ���� ���� : ������� Ʈ���ſ� ����� Ʈ���ŷ� ����
    (1) �������Ʈ���� : 'FOR EACH ROW' ����� ������� ���� ��� Ʈ���Ŵ� �̺�Ʈ�߻� ��[��]�� �ѹ� �߻�
                       WHEN ����, :NEW, :OLD���� ����� �� ����
                       
 ��뿹) �з����̺� ����(LPROD_ID)�� 10�̻�Ǵ� �ڷḦ ��� �����Ͻÿ�.
        ����(����) �� '�ڷᰡ �����Ǿ����ϴ�' ��� �޽����� ����ϴ� Ʈ���Ÿ� �ۼ��Ͻÿ�.
        
        (�ڷ� ���� Ʈ����)
        CREATE OR REPLACE TRIGGER TR_LPROD_DELETE
            AFTER DELETE ON LPROD
        BEGIN
            DBMS_OUTPUT.PUT_LINE('�ڷᰡ �����Ǿ����ϴ�.');
        END;
        
        (�ڷ� ���� ����)
        DELETE
          FROM LPROD
         WHERE LPROD_ID>=10;
    
         SELECT * FROM LPROD;
 
         
        (�ڷ� ���� Ʈ����) 
        CREATE OR REPLACE TRIGGER TR_LPROD_INSERT
            AFTER INSERT OR DELETE OR UPDATE ON LPROD
        BEGIN
            IF INSERTING THEN
                DBMS_OUTPUT.PUT_LINE('�ڷᰡ ���ԵǾ����ϴ�.');
            ELSIF UPDATING THEN
                DBMS_OUTPUT.PUT_LINE('�ڷᰡ �����Ǿ����ϴ�.');
            ELSIF DELETING THEN
                DBMS_OUTPUT.PUT_LINE('�ڷᰡ �����Ǿ����ϴ�.');
            END IF;
        END;
        
        (�ڷ� ���� ����)
        INSERT INTO LPROD VALUES(10,'p501','��깰');
        INSERT INTO LPROD VALUES(11,'p502','���깰');
        SELECT * FROM LPROD;
        
    (2) �����Ʈ���� : �̺�Ʈ�� �� �ึ�� Ʈ���� �߻�
      - Ʈ���� �ǻ緹�ڵ�
      -----------------------------------------------------------------------
      �ǻ緹�ڵ�             �ǹ�
      -----------------------------------------------------------------------
      :NEW                  INSERT, UPDATE �̺�Ʈ �߻��� ���
                            �����Ͱ� ����(����)�� ���Ӱ� ������ �ڷ� ��Ī
                            DELETE �̺�Ʈ���� ��� NULL ��
                            
      :OLD                  DELETE, UPDATE �̺�Ʈ �߻��� ���
                            �����Ͱ� ����(����)�� �̹� �����ϰ� �ִ� �ڷ� ��Ī
                            INSERT �̺�Ʈ���� ��� NULL ��
      -----------------------------------------------------------------------
      - Ʈ���� �Լ� : �߻��� �̺�Ʈ�� �����ϱ� ���� ���
      -----------------------------------------------------------------------
      �Լ�                  �ǹ�
      -----------------------------------------------------------------------
      INSERTING            �̺�Ʈ�� INSERT �̸� ��(true) ��ȯ
      UPDATING             �̺�Ʈ�� UPDATE �̸� ��(true) ��ȯ
      DELETING             �̺�Ʈ�� DELETE �̸� ��(true) ��ȯ
     -----------------------------------------------------------------------
     
     CREATE TABLE PRODUCT(
        PROD_ID  VARCHAR2(6) PRIMARY KEY,
        PROD_NAME VARCHAR2(12),
        PROD_COM VARCHAR2(12),
        PROD_SALE  NUMBER(8),
        PROD_STOCKS NUMBER  DEFAULT 0);
        
      CREATE TABLE IPGO(
        IPGO_ID NUMBER(6) PRIMARY KEY,
        PROD_ID VARCHAR2(6)REFERENCES PRODUCT(PROD_ID),
        IPGO_DAY DATE DEFAULT SYSDATE,
        IPGO_QTY NUMBER(6),
        IPGO_COST NUMBER(8),
        IPGO_AMT NUMBER(8));
      
      INSERT INTO PRODUCT(PROD_ID,PROD_NAME,PROD_COM,PROD_SALE)
          VALUES('A00001','��Ź��','LG',500);
      INSERT INTO PRODUCT(PROD_ID,PROD_NAME,PROD_COM,PROD_SALE)
          VALUES('A00002','��ǻ��','SAMSUNG',700);
      INSERT INTO PRODUCT(PROD_ID,PROD_NAME,PROD_COM,PROD_SALE)
          VALUES('A00003','�����','LG',600);
     
     COMMIT;
     
 Ʈ���� ��뿹) �԰����̺� ��ǰ�� �԰�Ǹ� ��ǰ���̺��� �������÷��� �������� �߰��Ǵ� Ʈ���� �ۼ�
            
            (Ʈ���� ����)
            CREATE OR REPLACE TRIGGER TG_INSERT_IPGO
                AFTER INSERT ON IPGO
                FOR EACH ROW
            BEGIN
                UPDATE PRODUCT
                   SET PROD_STOCKS = PROD_STOCKS + :NEW.IPGO_QTY
                 WHERE PROD_ID = :NEW.PROD_ID;
            END;
     
            (��ǰ �԰� �� ����)
            INSERT INTO IPGO
                VALUES (1, 'A00002', SYSDATE, 5, 600, 3000);
                
            INSERT INTO IPGO
                VALUES (2, 'A00001', SYSDATE, 10, 500, 5000);
                
            SELECT * FROM IPGO;
            SELECT * FROM PRODUCT
            ORDER BY 5 DESC;
            COMMIT;
            
 Ʈ���� ��뿹) �̹� �԰�� ��ǰ�� ������ ����� ��� ��ǰ���̺��� �������÷��� ���� �����ϴ� Ʈ���� �ۼ�
            
            (Ʈ���� ����)
            CREATE OR REPLACE TRIGGER TG_UPDATE_IPGO
                AFTER UPDATE ON IPGO
                FOR EACH ROW
            BEGIN
                UPDATE PRODUCT
                   SET PROD_STOCKS = PROD_STOCKS + :NEW.IPGO_QTY - :OLD.IPGO_QTY
                 WHERE PROD_ID = :NEW.PROD_ID;
            END;
       
            
            (���๮)
            UPDATE IPGO
               SET IPGO_QTY = IPGO_QTY +3
             WHERE PROD_ID = 'A00002';
             
            COMMIT;
            
              UPDATE IPGO
               SET IPGO_QTY = 5
             WHERE PROD_ID = 'A00001';
             
             SELECT * FROM IPGO;
             
 Ʈ���� ��뿹) �̹� �԰�� ��ǰ�� ������ �����ϴ� ��� ��ǰ���̺��� �������÷��� ���� �����ϴ� Ʈ���� �ۼ�
 
            CREATE OR REPLACE TRIGGER TG_DELETE_IPGO
                AFTER DELETE ON IPGO
                FOR EACH ROW
            BEGIN
                UPDATE PRODUCT
                   SET PROD_STOCKS = PROD_STOCKS - :OLD.IPGO_QTY
                 WHERE PROD_ID = :OLD.PROD_ID;
            END;
            
            (���� ����)
            DELETE 
              FROM IPGO
             WHERE IPGO_ID = 1;
             
            SELECT * FROM IPGO;
            SELECT * FROM PRODUCT;             

 Ʈ���� ��뿹) ���� 3���� Ʈ���Ÿ� �ϳ��� ������.
 
            CREATE OR REPLACE TRIGGER TG_IPGO
                AFTER INSERT OR DELETE OR UPDATE ON IPGO
                FOR EACH ROW
            BEGIN
                IF UPDATING THEN
                    UPDATE PRODUCT
                       SET PROD_STOCKS = PROD_STOCKS + :NEW.IPGO_QTY - :OLD.IPGO_QTY
                     WHERE PROD_ID = :NEW.PROD_ID;
                 
                ELSIF INSERTING THEN
                    UPDATE PRODUCT
                       SET PROD_STOCKS = PROD_STOCKS + :NEW.IPGO_QTY
                     WHERE PROD_ID = :NEW.PROD_ID;
                
                ELSIF DELETING THEN
                    UPDATE PRODUCT
                       SET PROD_STOCKS = PROD_STOCKS - :OLD.IPGO_QTY
                     WHERE PROD_ID = :OLD.PROD_ID;
                END IF;
            END;
 
 
            CREATE OR REPLACE TRIGGER TG_IPGO
                AFTER INSERT OR DELETE OR UPDATE ON IPGO
                FOR EACH ROW
            DECLARE
                V_QTY NUMBER:=0;
                V_PROD_ID PRODUCT.PROD_ID%TYPE;
            BEGIN 
                IF INSERTING THEN
                    V_QTY := :NEW.IPGO_QTY;
                    V_PROD_ID := :NEW.PROD_ID; 
                ELSIF UPDATING THEN
                    V_QTY := :NEW.IPGO_QTY - :OLD.IPGO_QTY;
                    V_PROD_ID := :NEW.PROD_ID; 
                ELSIF DELETING THEN
                    V_QTY := -(:OLD.IPGO_QTY);
                    V_PROD_ID := :OLD.PROD_ID;
                END IF;
                
                UPDATE PRODUCT
                   SET PROD_STOCKS = PROD_STOCKS + V_QTY
                 WHERE PROD_ID = V_PROD_ID;
            END;
 
 
 ***Ʈ���� ����
    DROP TRIGGER Ʈ���Ÿ�
    DROP TRIGGER TG_INSERT_IPGO;
    DROP TRIGGER TG_DELETE_IPGO;
    DROP TRIGGER TG_UPDATE_IPGO;
    COMMIT;
 
 
            UPDATE IPGO
               SET IPGO_QTY = 5
             WHERE PROD_ID = 'A00001';
             
            COMMIT;
  ** 2021-12-03�� 'A00001'�� 10�� �԰�
        INSERT INTO IPGO
            VALUES (3,'A00001',TO_DATE('20211203'), 10, 500, 5000);
         SELECT * FROM IPGO;
         SELECT * FROM PRODUCT;
  
  ** 2021-12-02 ��¥�� 'A00001'�� 3���� ����       
        UPDATE IPGO
           SET IPGO_QTY = 3,
               IPGO_AMT = 1500
         WHERE IPGO_ID = 2
           AND TO_DATE(IPGO_DAY,'YYYY/MM/DD') = TO_DATE('20211202');
           
  ** IPGO_ID �� 2�� 'A00001'�� �ڷḦ ����
        DELETE
          FROM IPGO
         WHERE IPGO_ID = 2;
           
         SELECT * FROM IPGO;
         SELECT * FROM PRODUCT;
        
  
 
 
        