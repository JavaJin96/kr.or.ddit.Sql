2021-1111-01)
 2. ���� �Լ�
  1) ������ �Լ�
   - ���п��� ���� ���Ǵ� ����, �ﰢ�Լ� ���� ����
   - ABS(n) : n�� ���� ���밪 ��ȯ
   - SIGN(n) : n�� ��ȣ ��(���� : -1 , ��� : 1, 0 : 0)�� ��ȯ
   - POWER (b, e) : b�� e�� (b�� e�� �ŵ� ���� ��)
   - SQRT(n) : n�� ���� ��
   
  2) GREATST(n1, n2[,n3,....]), LEAST(n1, n2[,n3...])
   - �־��� �ڷ�(n1, n2[,n3....]) �� ���� ū ��(GREATEST) �Ǵ� ���� ���� ��(LEAST)�� ��ȯ
   -- �����÷� �����÷� �����÷� �� ���� �÷� �߿��� ū �� ���� ���� ã�� ������ GREATST , LEAST�� ��ȯ
   -- �����÷� ������ ū �� ���� ���� ã�� ������ MAX , MIN ���(������ �׷� ������ ���)
   
 ��뿹) 
    SELECT GREATEST(10,20,30), LEAST(10,20,30),
           GREATEST('ȫ�浿','ȫ���','�̼���'), 
           LEAST('ȫ�浿', 'ȫ���', '�̼���'), -- ��,��,�� ������ ù° �� �������� ��° �� ...
           GREATEST('GREAT','500','�̼���'), -- ������ �ƽ�Ű�ڵ�� 500, �̼����� �ƽ�Ű�ڵ�� ��
           LEAST('GREAT', '500', '�̼���'),
           --ASCII(500)--53
           --ASCII('�̼���')--15506868
           --ASCII('GREAT')--71
    FROM DUAL;
    
 ��뿹) ȸ�����̺��� ���ϸ����� 1000 �̸��� ȸ���� ���ϸ����� 1000���� �ο��Ͻÿ�.
        Alias�� ȸ����ȣ, ȸ����, �������ϸ���, ���ο�ϸ���
        
        SELECT MEM_ID AS ȸ����ȣ,
                MEM_NAME AS ȸ����,
                MEM_MILEAGE AS �������ϸ���,
               GREATEST(MEM_MILEAGE,1000) AS ���ο�ϸ���
        FROM MEMBER
        WHERE MEM_MILEAGE < 1000;
        
 3) ROUND(n[, i]), TRUNC(n[, i])
  - �־��� �� n ���� �Ҽ��� (i+1) �ڸ����� �ݿø�(ROUND), �ڸ�����(TRUNC) �� ������ ����� ��ȯ
  - i �� �����Ǹ� 0���� ����
  - i �� ������ ��� �����κп��� �ڸ��ø��� �ڸ������� �߻�
 ��뿹)
        SELECT ROUND(123.345678,2), TRUNC(123.345678,2),
               ROUND(123.345678), TRUNC(123.345678),
               ROUND(123.345678,-2), TRUNC(123.345678,-2)
        FROM DUAL;
        
        
 ��뿹) ������̺��� ���������ڵ带 �̿��Ͽ� ���ʽ��� ����ϰ� ���޾��� ����Ͻÿ�.
        ���ʽ� = �޿�*���������ڵ��� 27%
        ���� = (�޿�+���ʽ�)�� 13%
        ���޾� = (�޿�+���ʽ�) - ����
        ** ��� �׸��� �Ҽ� ù°�ڸ����� ����Ұ�.
        
        SELECT  EMPLOYEE_ID AS �����ȣ,
                EMP_NAME AS �����,
                DEPARTMENT_ID AS �μ���ȣ,
                COMMISSION_PCT AS ���������ڵ�,
                SALARY AS �޿�
                ROUND (SALARY * NVL(COMMISSION_PCT,0)*0.27,1) AS ���ʽ�,
                ROUND ((SALARY * (SALARY*NVL(COMMISSION_PCT,0)*0.27))*0.13,1) AS ����,
                ((SALARY * (SALARY*NVL(COMMISSION_PCT,0)*0.27))
                -((SALARY * (SALARY*NVL(COMMISSION_PCT,0)*0.27)*0.13),1) AS ���ݾ�
        FROM HR.EMPLOYEES;
        
        
 4) FLOOT(n), CEIL(n)
  - FLOOR : n�� ���ų� ������ �� ���� ū��
  - CEIL : n�� ���ų� ū�� �� ���� ������
  
 ��뿹) SELECT FLOOR(20), FLOOR(20.7), FLOOR(-20.7),
               CEIL(20), CEIL(20.7), CEIL(-20.7)
        FROM DUAL;

 5)MOD(n,c), REMAINDER(n,c)
  - n�� c�� ���� �������� ��ȯ��
  - MOD�� REMAINDER �� ���ο��� ó���ϴ� ����� �ٸ�
  - MOD �� ������ ������ ��ȯ, REMAINDER �� ���� �������� ������ ���ݺ��� ũ�� ���������� ���� ���� ���� �������� �� ���� ��ȯ
  ex)
    MOD(10,7) : 10 - 7 * FLOOR(10/7)
              = 10 - 7 * FLOOR(1.428..)
              = 10 - 7 *
              = 3
    REMAINDER(10,7)
              = 10 - 7 * ROUND(10/7)
              = 10 - 7 * ROUND(1.428..)
              = 10 - 7 *
              = 3
              
    MOD(12,7) : 12 - 7 * FLOOR(12/7)
              = 12 - 7 * FLOOR(1.714..)
              = 12 - 7 * 1
              = 5
    REMAINDER(12,7)
              = 12 - 7 * ROUND(12/7)
              = 12 - 7 * ROUND(1.714..)
              = 12 - 7 * 2
              = -2
  
  SELECT MOD(10,7), REMAINDER(10,7), MOD(12,7), REMAINDER(12,7) FROM DUAL;
  -- 10/ 7 �������� ����
  
 ��뿹) Ű����� ������ �Է� �޾� �ش�⵵�� �������� ������� �����Ͻÿ�.
        ���� : 4�� ����鼭 100�� ����� �ƴ� ���̰ų� 400�� ������Ǵ� ��
        
        ACCEPT P_YEAR PROMT '�⵵�Է� : '
        DECLARE
            V_YEAR NUMBER:=TO_NUMBER('&P_YEAR');
            V_RES VARCHAR2(255);
        BEGIN
            IF (MOD(V_YEAR,4)=0 AND MOD(V_YEAR,100)!=0) OR (MOD(V_YEAR,400)=0) THEN
                V_RES:=V_YEAR||'�⵵�� �����Դϴ�!.';
            ELSE
                V_RES:=V_YEAR||'�⵵�� ����Դϴ�!.';
        END IF;
        
        DBMS_OUTPUT.PUT_LINE(V_RES); --System.out.println() �� ���
    END;
        
        
        
           
           