2021-1129-03)
    2. SEQUENCE
     - �������� ���� �����ϱ����� ��ü
     - ���̺�� �������� �� ����
     - �������� ���Ǵ� ��
      . ������ �⺻Ű�� ã�� ���� ���
      . �ڵ������� ����(����) �Ǵ� ���� �ʿ��� ���(ex CART_NO�� ���ڸ� 5���� ��)
      (�������)
      CREATE [OR REPLACE] SEQUENCE ��������
        [START WITH n ]  -- ���۰� ���� �⺻�� MIN_VALUE
        [INCREMENT BY n] -- ����[����] �� �⺻�� 1(���� ��� ����)
        [MAXVALUE n|NOMAXVALUE] -- �ִ밪 ����, default NOMAXVALUE �̸� 10^27
        [MINVALUE n|NOMINVALUE] -- �ּҰ� ����, default NOMINVALUE �̸� 1 �̴�.
        [CYCLE|NOCYCLE] -- �ִ�(�ּ�) ������ ������ �� �ٽ� �������� ���� default �� NOCYCLE
        [CACHE n|NOCACHE]  -- �޸𸮿� �̸� ������ ���� ���� ���� default �� CACHE 20
        [ORDER|NOORDER] -- ���õ� ���Ǵ�� ������ �������� ���� default �� NOORDER
        
 ** �ǻ��÷�(Pseudo Column)
 ----------------------------------------------------------------------------
    �ǻ��÷�                    �ǹ�
 ----------------------------------------------------------------------------
 ��������.nextval               '������'�� ���� ��
 ��������.currval               '������'�� ���� ��
 ----------------------------------------------------------------------------
 **** �������� ������ �� ��� ������ �ѹ��� nextval �� ȣ��Ǿ�� �ش� �������� ���� ���� ����
 
  ��뿹) ���� �ڷḦ �з����̺� �����Ͻÿ�.
        [�ڷ�]
        ���� : 10
        �з��ڵ� : 'p501'
        �з��� : ��깰
        
        ���� : 11
        �з��ڵ� : 'p502'
        �з��� : ��갡����ǰ
        
        ���� : 12
        �з��ڵ� : 'p503'
        �з��� : �ӻ깰
        
        **������ �������� ����� ��
        
        (������ ����)
        CREATE SEQUENCE SEQ_LPROD
        START WITH 10; 
        
            SELECT SEQ_LPROD.CURRVAL FROM DUAL;
            SELECT SEQ_LPROD.NEXTVAL FROM DUAL;
        (�ڷ� ����)
        INSERT INTO LPROD(LPROD_ID, LPROD_GU, LPROD_NM)
            VALUES (SEQ_LPROD.NEXTVAL, 'p501', '��깰');
        
        INSERT INTO LPROD(LPROD_ID, LPROD_GU, LPROD_NM)
            VALUES (SEQ_LPROD.NEXTVAL, 'p502', '��깰������ǰ');
            
        INSERT INTO LPROD(LPROD_ID, LPROD_GU, LPROD_NM)
            VALUES (SEQ_LPROD.NEXTVAL, 'p503', '�ӻ깰');
            
        SELECT * FROM LPROD;
        
 ��뿹) ������ 2005�� 7�� 29�� �̶�� �����ϰ� CART_NO�� �����Ͻÿ�.
        5�ڸ� ���ڴ� �������� �̿��� ��
        
        CREATE SEQUENCE SEQ_CART_NO
            START WITH 1
            MAXVALUE 99999;
    
    
    -------------------------------------------------------------------------------
        
        ACCEPT P_MID    PROMPT 'ȸ����ȣ : '
        DECLARE
            V_DATE VARCHAR2(9) := TO_CHAR(SYSDATE,'YYYYMMDD')|| '%';
            V_LNUM NUMBER := 0;
            V_CNT VARCHAR2(20);
            V_MID MEMBER.MEM_ID%TYPE;
        BEGIN
            SELECT MAX(CART_NO) INTO V_CNT
              FROM CART
             WHERE CART_NO LIKE V_DATE           
        END;
        
        
        SELECT SEQ_CART_NO.NEXTVAL FROM DUAL;
        SELECT SEQ_CART_NO.currval FROM DUAL;
        

    3. ���Ǿ�(synonym)
    - ����Ŭ ��ü�� �ο��� ������ �Ǵٸ� �̸�
    - ��Ī(���̺�)���� �������� ���������� ����(���̺�Ī : ���Ǵ� sql ����, ���Ǿ�� ��� ������ ���)
    (�������)
        CREATE [OR REPLACE] SYNONYM ���Ǿ� FOR ��ü��;
         . '��ü��' : ���� ��ü��
         
��뿹) HR������ ������̺�(HR.EMPLOYEES)�� ���Ǿ� EMP�� �����Ͻÿ�.
        CREATE OR REPLACE SYNONYM EMP FOR HR.EMPLOYEES;
        
        SELECT * FROM EMP;
        