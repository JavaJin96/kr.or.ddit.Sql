2021-1130-05)CURSOR
 -SQL��ɿ� ���Ͽ� ������� ����� ����(�迭??)
 -SELECT���� ��� ����
 -������ Ŀ�� (Implicit Cursor)�� ����� Ŀ��(Explicit Cursor)�� ����
  1) ������ Ŀ�� (Implicit Cursor)
   .�̸��� ���� Ŀ�� 
   .�ѹ����� ������
   .sql������ ����� ���ÿ� ���������� ������ Ŀ���� �������
   (Ŀ���Ӽ�)
   -----------------------------------------------------------------------
      �Ӽ�              �ǹ�
   -----------------------------------------------------------------------
   SQL%FOUND        ��������� FETCH ROW��(���� ����)�� 1���� ������ �� --LOOP���� ���������� �ɶ� ���� ���.
   SQL%NOTFOUND     ��������� FETCH ROW���� ������ ��, ������ ����
   SQL%ROWFOUND     ��������� ROW�� ��ȯ
   SQL%ISOPEN       Ŀ���� OPEN�����̸� ��(������Ŀ���� �׻� ������)
   
   2) ����� Ŀ�� (Explicit Cursor)
   .�̸��� �ִ� Ŀ��
   .Ŀ���� ��빮 ���� => OPEN => FETCH => CLOSE 4�ܰ�� ����
   (1) Ŀ�� ����
    . DECLARE �������� ����
        (��������)
        CURSOR Ŀ����[(�Ű�����list)] --CUR_...���� ����Ǵ� ����
        IS
        SELECT ��;
            .'�Ű�����list': Ŀ�� ����� ���� �����͸� ���� ���� ������ 
                ������ ������Ÿ�� ������ ����Ǹ� �����ʹ� OPEN������ �����Ѵ�.
    (2) OPEN �� 
     . ����� Ŀ�� ����
     . BEGIN ��Ͽ��� ���
         (�������)
         OPEN Ŀ���� [(�Ű�����list)] --���� �����͸� �� �ܰ迡�� �־��ִ°�(�����ش�?)�̴�.
          
    (3) FETCH ��
       .Ŀ������ �ڷḦ ������� �о���� ���(READ���� ���� ���)
       .���� ������� �ȿ� ��ġ
         (�������)
          FETCH Ŀ���� INTO ����,����,...����;
       . Ŀ������ SELECT ���� �÷����� INTO���� ������ ���� ����, ������ Ÿ���� ��ġ�ؾ� ��
       . Ŀ������ ���̻� FETCH�� ROW�� ������ Ŀ���Ӽ� Ŀ����%NOTFOUND�� ���̵� 
        --WHILE �� ����� : EXIT WHEN Ŀ����%FOUND;
        --LOOP�� �������� : Ŀ����%NOTFOUND;
        --FOR���� �ڱⰡ �˾Ƽ� ������ ������ Ŀ���Ӽ��� �Ƚᵵ�ȴ�~
        --Ŀ���� FOR���� ���� ������ �߸´� ��ɾ�(?)�̴�~
       . Ŀ���Ӽ��� ������ Ŀ���Ӽ��� ������ 'SQL'��� Ŀ������ �����
        ex) Ŀ����%FOUND,Ŀ����%NOTFOUND,Ŀ����%ISOPEN,Ŀ����%ROWCOUNT,..
        
    (4)CLOSE ��
       . ����� ����� Ŀ���� �ݵ�� CLOSE �ؾ��� 
       
    ��뿹) ������̺��� 80���μ��� ���� ����� �̸�, �Ի��� ������带 
          ����ϴ� ����� Ŀ���� �̿��Ͽ� �ۼ��Ͻÿ�.
          
        (Ŀ���κ�: �ش�μ��� ���� �����,�����ڵ�,�Ի����� ���)
         SELECT EMP_NAME,JOB_ID,HIRE_DATE
           FROM EMP
           WHERE DEPARTMENT_ID = 80;
    
     
    
    DECLARE
       CURSOR CUR_EMP(P_DID EMP.DEPARTMENT_ID%TYPE) --�Ű������� ��ȣ�ȿ� �����ؾ����� ������ ��� �ǳ���?
       IS 
         SELECT EMP_NAME,JOB_ID,HIRE_DATE
           FROM EMP
          WHERE DEPARTMENT_ID = P_DID;
        V_ENAME EMP.EMP_NAME%TYPE;
        V_JID EMP.JOB_ID%TYPE;
        V_HDATE DATE;
        
     BEGIN
        OPEN CUR_EMP(80);
        LOOP 
         FETCH CUR_EMP INTO V_ENAME,V_JID,V_HDATE;
         EXIT WHEN CUR_EMP%NOTFOUND; -- FETCH�� EXIT ���� �־���� WHY? �׷��� ���� �� ����
                                     --�����ڷᰡ ���� ������ �� -> LOOP�� ��������
         DBMS_OUTPUT.PUT_LINE('����� : '||V_ENAME);
         DBMS_OUTPUT.PUT_LINE('�����ڵ� : '||V_JID);
         DBMS_OUTPUT.PUT_LINE('�Ի��� : '||V_HDATE);
         DBMS_OUTPUT.PUT_LINE('=========================');
        END LOOP;
         DBMS_OUTPUT.PUT_LINE('����� : '||CUR_EMP%ROWCOUNT);
     END;
     
     
     ��뿹) ȸ�����̺��� ���ϸ����� ���� 5����� ��ȸ�Ͻð�, �� ȸ������ 2005�⵵ 
           �������踦 ��ȸ�Ͻÿ�. ȸ����ȣ, ȸ����,  --��κ��� Ŀ���� ����Ұ��ΰ�? 
           SELECT A.MEM_ID AS MID,A.MEM_NAME AS MNAME
           FROM(SELECT MEM_ID, MEM_NAME, MEM_MILEAGE
             FROM MEMBER 
             ORDER BY MEM_MILEAGE DESC)A
           WHERE ROWNUM <=5;   --Q1. ROWNUM�� 1�̻��� �� ��������? ������????
           
           
           
    
        DECLARE 
          CURSOR CUR_MILEAGE --�Ű����� �Ƚ����� 110LINE �� �Ƚᵵ��
          IS
           SELECT A.MEM_ID AS MID,A.MEM_NAME AS MNAME
             FROM(SELECT MEM_ID, MEM_NAME, MEM_MILEAGE
                    FROM MEMBER 
                   ORDER BY MEM_MILEAGE DESC)A
            WHERE ROWNUM <=5;  
            V_MNAME MEMBER.MEM_NAME%TYPE;
            V_MID MEMBER.MEM_ID%TYPE;
       --�����հ� ����
       --�ݾ��հ� �ں���
            V_SUM NUMBER :=0;
            
        BEGIN
          OPEN CUR_MILEAGE;
          LOOP 
             FETCH CUR_MILEAGE INTO V_MID,V_MNAME;
          EXIT WHEN CUR_MILEAGE%NOTFOUND;
          --������ �ʴ´ٸ� ȸ���� ���űݾ��� ã�Ƽ� ����϶� �ڵ��Է�
          SELECT SUM(A.CART_QTY*B.PROD_PRICE) INTO V_SUM
            FROM CART A, PROD B 
            WHERE A.CART_PROD=B.PROD_ID
              AND A.CART_NO LIKE '2005%'
              AND A.CART_MEMBER = V_MID;
              
              DBMS_OUTPUT.PUT_LINE('ȸ����ȣ : '||V_MID);
              DBMS_OUTPUT.PUT_LINE('ȸ���̸� : '||V_MNAME);
              DBMS_OUTPUT.PUT_LINE('���űݾ� : '||V_SUM);
              DBMS_OUTPUT.PUT_LINE('===================================');
          END LOOP;
        END;
          
             
    
    
    
    
    --Ŀ���� ����� �� �߿�����? �ʿ伺�� ���� �˷��ִ� ����
    --Ŀ���� �ٽ� ����� �� �ִ��� ? 
    