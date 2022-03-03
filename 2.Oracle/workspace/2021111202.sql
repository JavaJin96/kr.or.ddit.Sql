2021-1112-02)
 3. ��¥�Լ�
  1) SYSDATE
   - �ý����� �����ϴ� ��¥ �� �ð����� ����
   - �⺻ ��¥ �ڷ� (YYYY/MM/DD HH24:MI:SS)Ÿ��
   - '+', '-' ���� : ����(����)�� ��¥ ��ȯ
   - ��¥�ڷ� ������ ���� : �� ��¥������ �ϼ�(DAYS) ��ȯ
   
 ��뿹) SELECT SYSDATE, SYSDATE+20, SYSDATE-20, SYSDATE-TO_DATE('20201112'),
                ROUND(SYSDATE-TO_DATE('20201112'),0), 
                TRUNC (SYSDATE-TO_DATE('20201112')) 
        FROM DUAL;
        
  2) ADD_MONTHS (d,n)
   - �־��� ��¥�ڷ� d�� n��ŭ�� ���� ���� ���� ��ȯ
   
 ��뿹) 
        SELECT EMPLOYEE_ID AS �����ȣ,
                EMP_NAME AS �����,
                HIRE_DATE AS �Ի���,
                ADD_MONTHS(HIRE_DATE, 3) AS �߷���
        FROM HR.EMPLOYEES;
   
 ��뿹) ���Ի�ǰ�� ���� �������� ������ ���� 2���� �� �̴�. 2005�� 3�� ���ں� �����ұݾ��� ��ȸ�Ͻÿ�.
        Alias�� ��¥, �����ݾ��̴�. 
        
        SELECT ADD_MONTHS(A.BUY_DATE,2) AS ��¥,
                TO_CHAR(A.BSUM,'999,999,999') AS �����ݾ�
        FROM (SELECT BUY_DATE,
                    SUM(BUY_QTY*BUY_COST) AS BSUM
                    FROM BUYPROD
        WHERE ADD_MONTHS(BUY_DATE,2) BETWEEN TO_DATE('20050301')
                AND TO_DATE('20050331')
        GROUP BY BUY_DATE)A
        

  3) NEXT_DAY(d, fmt), LAST_DAY(d)
   - NEXT_DAY : �־��� ��¥ d ���Ŀ� ó�� ������ 'fmt'�� �ü��� ������ ��¥ ��ȯ.
                'fnt' �� ���Ϸ� '��', '������',..���� ���
   - LAST_DAY : �־��� ��¥ d�� ���Ե� ���� ���������ڰ� ���Ե� ��¥ ��ȯ.
   
 ��뿹) 2005�� 2�� ���ں� �������踦 ��ȸ�Ͻÿ�.
        Alias�� ��¥, ���Լ����հ�, ���Աݾ��հ�
        
        SELECT  BUY_DATE AS ��¥,
                SUM(BUY_QTY) AS ���Լ����հ�,
                SUM(BUY_QTY * BUY_COST) ���Աݾ��հ�
        FROM BUYPROD
        WHERE BUY_DATE BETWEEN TO_DATE('20050201') AND LAST_DAY(TO_DATE('20050201'))
        GROUP BY BUY_DATE
        ORDER BY 1;
                

  4) MONTHS_BETWEEN(d1,d2)
   - �־��� �� ��¥ �ڷ� d1�� d2 ������ ���� ���� ��ȯ

 ��뿹) ȸ������ ��Ȯ�� ���̸� ��ȸ�Ͻÿ�.
        Alias�� ȸ����ȣ, ȸ����, �������, ����
        ��, ���̴� xx�� xx���� ���
        
        SELECT MEM_ID AS ȸ����ȣ,
                MEM_NAME AS ȸ����,
                MEM_BIR AS �������,
                TRUNC (ROUND(MONTHS_BETWEEN(SYSDATE,MEM_BIR)) / 12)||'Y' || 
                MOD(ROUND(MONTHS_BETWEEN(SYSDATE,MEM_BIR)), 12)||'M' AS ����
        FROM MEMBER;
        
  5) EXTRACT(fmt FROM d)
   - ��¥�ڷ� d�� ���Ե� �� ��� (fmt : ��, ��, ��, ��, ��, ��) ���� ��ȯ
   - fmt �� YEAR, MONTH, DAY, HOUR, MINUTE, SECOND
   - ����� ��ȯ�Ǵ� ������ Ÿ���� ��������
   
**MEMBER ���̺��� ���� �ڷḦ �����Ͻÿ�.
   ȸ����ȣ :  d001
   ������� : 1946/04/09 -> 2000/04/09
   �ֹι�ȣ1: 460409 -> 000409
   �ֹι�ȣ2: 2000000 -> 4234654
   
   ȸ����ȣ :  k001
   ������� : 1962/01/03 -> 2001/01/23
   �ֹι�ȣ1: 620123 -> 010123
   �ֹι�ȣ2: 1449311 -> 3449311
   
   ȸ����ȣ :  v001
   ������� : 1952/01/31 -> 2004/01/31
   �ֹι�ȣ1: 520131 -> 040131
   �ֹι�ȣ2: 2402712 -> 3402712
   
   
   UPDATE MEMBER
   SET MEM_BIR = TO_DATE('20000409'),
        MEM_REGNO1 = '000409',
        MEM_REGNO2 = '4234654'
    WHERE LOWER(MEM_ID) = 'd001';
        

        COMMIT;
        
        
        
        
        