CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    category VARCHAR(100),
    stock INT DEFAULT 0,
    image_url VARCHAR(255)
);

INSERT INTO products (name, description, price, category, stock, image_url) VALUES
('무선 블루투스 이어폰', '고음질 무선 이어폰, 노이즈 캔슬링 지원', 89000.00, '전자기기', 150, 'https://example.com/images/earphones.jpg'),
('스마트워치 X200', '헬스 트래킹 기능 탑재 스마트워치', 129000.00, '전자기기', 85, 'https://example.com/images/smartwatch.jpg'),
('게이밍 마우스 G5', 'RGB LED 지원, 초고속 반응속도', 49000.00, '컴퓨터 주변기기', 230, 'https://example.com/images/mouse.jpg'),
('기계식 키보드 K87', '청축 기계식 키보드, RGB 백라이트', 69000.00, '컴퓨터 주변기기', 120, 'https://example.com/images/keyboard.jpg'),
('27인치 FHD 모니터', '초슬림 베젤, IPS 패널', 179000.00, '모니터', 45, 'https://example.com/images/monitor.jpg'),
('USB-C 고속 충전기', '최대 65W 고속충전 지원', 29000.00, '전자기기', 300, 'https://example.com/images/charger.jpg'),
('남성용 패딩 점퍼', '겨울용 방풍 방한 패딩', 99000.00, '의류', 70, 'https://example.com/images/jacket.jpg'),
('여성용 코튼 티셔츠', '기본핏 데일리 티셔츠', 19000.00, '의류', 200, 'https://example.com/images/tshirt.jpg'),
('남성 러닝화', '충격 흡수 기능성 운동화', 69000.00, '신발', 110, 'https://example.com/images/runningshoes.jpg'),
('여성 스니커즈', '가벼운 착용감, 데일리 스니커즈', 59000.00, '신발', 95, 'https://example.com/images/sneakers.jpg'),
('프리미엄 노트북 가방', '노트북 보호 충격방지 가방', 39000.00, '가방', 130, 'https://example.com/images/bag.jpg'),
('10000mAh 보조배터리', '슬림형 대용량 보조배터리', 27000.00, '전자기기', 180, 'https://example.com/images/powerbank.jpg'),
('무선 청소기 V10', '강력한 흡입력의 무선 청소기', 249000.00, '생활가전', 35, 'https://example.com/images/vacuum.jpg'),
('에어프라이어 5L', '기름 없이 튀기는 에어프라이어', 99000.00, '생활가전', 50, 'https://example.com/images/airfryer.jpg'),
('커피 그라인더', '원두를 신선하게 갈아주는 전동 그라인더', 49000.00, '주방용품', 90, 'https://example.com/images/grinder.jpg'),
('텀블러 500ml', '스테인리스 이중 진공 텀블러', 19000.00, '주방용품', 300, 'https://example.com/images/tumbler.jpg'),
('프리미엄 수건 3세트', '흡수력 좋은 고급 수건', 15000.00, '생활용품', 250, 'https://example.com/images/towel.jpg'),
('아로마 캔들', '라벤더 향의 릴렉싱 캔들', 12000.00, '인테리어', 160, 'https://example.com/images/candle.jpg'),
('데스크 LED 스탠드', '눈부심 방지 조명, 밝기 조절 가능', 42000.00, '조명', 80, 'https://example.com/images/ledlamp.jpg'),
('심플 데스크 의자', '허리 지지 기능성 의자', 129000.00, '가구', 20, 'https://example.com/images/chair.jpg');
