2021-1130-02) PL/SQL
 -Procedural Language SQL
 -ǥ�� SQL�� ���������� ���(����,�ݺ���,�б⹮ ��)�� �������� �ʾ� ����� �������̾���
 -������ ���డ���� ���·� ����Ǿ� ����(���� ��Ƽ��ũ�� ȿ�������)
 -���ȭ,ĸ��ȭ�� ��� ����
 -ǥ�ع����� ���� �� DBMS�� ��������
 -�͸���(Anonymous block), Stored Procedure, User defined Function, Pakage, Trigger(INSERT,DELETE,UPDATE ���?) �� ����
 
 
 1. �͸���(Anonymous block)
  -PL/SQL�� �⺻ ���� ����
  -������ �� ����
  (ǥ������)
    --�͸������� ���ν����� ���̰ų� FUNCTION�� ���ϼ� �ִ�. �����Ѱ��� �ƴϴ�.
    DECLARE
      �����; --����,���,Ŀ��(=VIEW,SQL�������� ����Ǿ��� ��� ����) ����
      BEGIN
       �����; --ó���� ����� ���������� ���
              --SQL��, �ݺ���, �б⹮ �� 
   [EXCEPTION] 
    ����ó����; --���ܹ߻��� ó���� ��� ��� 
      
       END;  --����� ���� ����
    
     ACCEPT P_YEAR PROMPT '�⵵�Է� : '
     DECLARE 
      V_YEAR NUMBER := TO_NUMBER('&P_YEAR');
      V_RES VARCHAR2(200);
       BEGIN 
         IF(MOD(V_YEAR,4)=0 AND MOD(V_YEAR,100)!=0) OR(
            MOD(V_YEAR,400)=0) THEN
            V_RES:= V_YEAR||'���� �����Դϴ�.';
         ELSE
            V_RES:= V_YEAR||'���� ����Դϴ�.';
      END IF;
      DBMS_OUTPUT.PUT_LINE(V_RES);
      END;
      
    1) ����, ��� ����
    (�������)
    �ĺ��� [CONSTANT] ������Ÿ��|����Ÿ�� [:=�ʱⰪ];
    . '�ĺ���' : ������ �Ǵ� �����
    . '������Ÿ��' : SQL���� ����ϴ� ��� ������Ÿ��
      - �׿�) PLS_INTEGER, BINARY_INTEGER : 4BYTE ����(2147483647~-2147483648)
      - BOOLEAN �� ������
    . '����Ÿ��'
      - �÷����� : ���̺��.�÷���.&TYPE : �ش� �÷��� ������ ������Ÿ�԰� ũ��� ��������
      - ������ : ���̺��%ROWTYPE : �ش� �� ��ü�� �����Ͽ� ��������(C����� ����ü(Class)�� ����Ÿ��)
        --�迭ó�� ���� �ִ�..? �࿡ �ش��ϴ� ������ Ÿ���� �����ִٴ� ���??
    . ��������� 'CONSTANT' ����ϸ� �ݵ�� �ʱⰪ�� �����ؾ� ��. 
    (��뿹1_ ȸ�����̺��� ���ϸ����� ��ȸ�Ͽ� 5000�̻��̸� 'VIPȸ��',
            �� �����̸� '�Ϲ�ȸ��'�� ����� ����ϴ� �͸����� �ۼ�
             ����� �÷��� ȸ����ȣ,ȸ����,���ϸ���,���
             
        DECLARE
            V_MID MEMBER.MEM_ID%TYPE;
            V_NAME MEMBER.MEM_NAME%TYPE;
            V_MILE MEMBER.MEM_MILEAGE%TYPE;
            V_BIGO VARCHAR2(30);
        
       
        BEGIN
            SELECT MEM_ID,MEM_NAME,MEM_MILEAGE 
              INTO V_MID,V_NAME,V_MILE
              FROM MEMBER
              WHERE ROWNUM=1;
             IF
                V_MILE >5000 THEN V_BIGO :='VIPȸ��';
             ELSE 
                V_BIGO :='�Ϲ�ȸ��';
            END IF;
            DBMS_OUTPUT.PUT_LINE('ȸ����ȣ : '||V_MID);
            DBMS_OUTPUT.PUT_LINE('ȸ���̸� : '||V_NAME);
            DBMS_OUTPUT.PUT_LINE('���ϸ��� : '||V_MILE);
            DBMS_OUTPUT.PUT_LINE('��� : '||V_BIGO);
            DBMS_OUTPUT.PUT_LINE('==========================');
        END;
        
        (** Ŀ�����)
         DECLARE
            V_BIGO VARCHAR2(30);
            CURSOR CUR_MEMBER IS
              SELECT MEM_ID,MEM_NAME,MEM_MILEAGE
                FROM MEMBER;
       
        BEGIN
            FOR REC IN CUR_MEMBER LOOP
              IF REC.MEM_MILEAGE > 5000 THEN
               V.BIGO:='VIPȸ��';
            SELECT MEM_ID,MEM_NAME,MEM_MILEAGE 
              INTO V_MID,V_NAME,V_MILE
              FROM MEMBER
              WHERE ROWNUM=1;
             IF
                V_MILE >5000 THEN V_BIGO :='VIPȸ��';
             ELSE 
                V_BIGO :='�Ϲ�ȸ��';
            END IF;
            DBMS_OUTPUT.PUT_LINE('ȸ����ȣ : '||V_MID);
            DBMS_OUTPUT.PUT_LINE('ȸ���̸� : '||V_NAME);
            DBMS_OUTPUT.PUT_LINE('���ϸ��� : '||V_MILE);
            DBMS_OUTPUT.PUT_LINE('��� : '||V_BIGO);
            DBMS_OUTPUT.PUT_LINE('==========================');
        END;
            
            
    
    
    
    