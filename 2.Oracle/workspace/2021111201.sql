2021-1112-01)

 6) WIDTH_BUCKET (n, min, max, b)
  - �־��� ������ ���Ѱ�(min)�� ���Ѱ�(max)�� b���� �������� ���� �� �� n �� ��� ������ ���ϴ����� �Ǻ��Ͽ� ������ ������ ��ȯ�� ��.
  
 ��뿹) SELECT WIDTH_BUCKET(56, 0, 100, 10),
               WIDTH_BUCKET(100, 0, 100, 10),
               WIDTH_BUCKET(0, 0, 100, 10),
               WIDTH_BUCKET(120, 0, 100, 10)
        FROM DUAL;
        
 ��뿹) ȸ������ �����ϰ� �ִ� ���ϸ����� ������ 1000 ~ 8000 ���� �����ϰ� �̸� 8���� �������� �����Ͽ�, ȸ������ ���ϸ����� ��� ������ ���ϴ��� �Ǻ��ϴ� ������ �ۼ��Ͻÿ�.
        Alias�� ȸ����ȣ, ȸ����, ���ϸ���, ������
        ��, �������� ���� ���ϸ����� ���� ����� ���� �������� ������ �����Ͻÿ�.
        
        SELECT MEM_ID AS ȸ����ȣ,
                MEM_NAME AS ȸ����,
                MEM_MILEAGE AS ���ϸ���,
                WIDTH_BUCKET(MEM_MILEAGE,1000, 8000, 8) AS ������1,
                WIDTH_BUCKET(MEM_MILEAGE,8000, 1000, 8) AS ������2
               -- 9- WIDTH_BUCKET(MEM_MILEAGE,1000, 8000, 8) AS ������3
               -- 9- WIDTH_BUCKET(MEM_MILEAGE,8000, 999, 8) AS ������2,
        FROM MEMBER
        ORDER BY 4 DESC;
        
        
        -- �����Լ��� ��� ROUND(�ݿø�) MOD ���� ���ȴ�.
    