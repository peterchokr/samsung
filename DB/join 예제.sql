-- ============================================
-- MySQL 조인(JOIN) 실습 예제
-- ============================================

-- 데이터베이스 생성 및 선택
DROP DATABASE IF EXISTS join_practice;
CREATE DATABASE join_practice;
USE join_practice;

-- ============================================
-- 1. 테이블 생성
-- ============================================

-- 부서 테이블
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL,
    location VARCHAR(50)
);

-- 직원 테이블
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50) NOT NULL,
    dept_id INT,
    salary DECIMAL(10, 2),
    hire_date DATE,
    manager_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- 프로젝트 테이블
CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    budget DECIMAL(12, 2),
    start_date DATE
);

-- 직원-프로젝트 연결 테이블 (다대다 관계)
CREATE TABLE employee_projects (
    emp_id INT,
    project_id INT,
    role VARCHAR(50),
    hours_worked INT,
    PRIMARY KEY (emp_id, project_id),
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id),
    FOREIGN KEY (project_id) REFERENCES projects(project_id)
);

-- ============================================
-- 2. 샘플 데이터 삽입
-- ============================================

-- 부서 데이터
INSERT INTO departments VALUES
(1, '개발팀', '서울'),
(2, '마케팅팀', '부산'),
(3, '인사팀', '서울'),
(4, '재무팀', '대구'),
(5, '디자인팀', '인천');

-- 직원 데이터 (일부는 부서 미배정)
INSERT INTO employees VALUES
(101, '김철수', 1, 5500000, '2020-01-15', NULL),
(102, '이영희', 1, 4800000, '2021-03-20', 101),
(103, '박민수', 2, 4500000, '2020-06-10', NULL),
(104, '정수진', 2, 4200000, '2022-01-05', 103),
(105, '최동욱', 3, 4000000, '2021-08-12', NULL),
(106, '강지은', 1, 5200000, '2019-11-30', 101),
(107, '윤서연', NULL, 3800000, '2023-02-14', NULL),  -- 부서 미배정
(108, '한민재', NULL, 3900000, '2023-05-20', NULL),  -- 부서 미배정
(109, '임하늘', 4, 4600000, '2021-04-18', NULL);

-- 프로젝트 데이터
INSERT INTO projects VALUES
(201, '모바일 앱 개발', 50000000, '2023-01-10'),
(202, '마케팅 캠페인', 30000000, '2023-03-15'),
(203, '신규 웹사이트 구축', 45000000, '2023-02-01'),
(204, '인사 시스템 구축', 25000000, '2023-06-01'),
(205, 'AI 챗봇 개발', 60000000, '2023-07-01');  -- 담당자 없음

-- 직원-프로젝트 연결 데이터
INSERT INTO employee_projects VALUES
(101, 201, '프로젝트 매니저', 120),
(102, 201, '개발자', 150),
(106, 201, '개발자', 140),
(103, 202, '마케팅 리드', 100),
(104, 202, '마케팅 담당', 110),
(101, 203, '기술 자문', 50),
(102, 203, '풀스택 개발자', 160),
(105, 204, 'HR 담당', 130);

-- ============================================
-- 3. INNER JOIN (내부 조인)
-- ============================================
-- 양쪽 테이블에 모두 존재하는 데이터만 반환

-- 예제 1: 직원과 부서 정보 조인
SELECT 
    e.emp_id,
    e.emp_name,
    d.dept_name,
    d.location,
    e.salary
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id
ORDER BY e.emp_id;

-- 예제 2: 직원, 부서, 프로젝트 3개 테이블 조인
SELECT 
    e.emp_name AS 직원명,
    d.dept_name AS 부서명,
    p.project_name AS 프로젝트명,
    ep.role AS 역할,
    ep.hours_worked AS 작업시간
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id
INNER JOIN employee_projects ep ON e.emp_id = ep.emp_id
INNER JOIN projects p ON ep.project_id = p.project_id
ORDER BY e.emp_name;

-- ============================================
-- 4. LEFT JOIN (왼쪽 외부 조인)
-- ============================================
-- 왼쪽 테이블의 모든 데이터 + 오른쪽 테이블의 매칭 데이터

-- 예제 1: 모든 직원과 부서 정보 (부서 미배정 직원 포함)
SELECT 
    e.emp_id,
    e.emp_name,
    COALESCE(d.dept_name, '미배정') AS dept_name,
    e.salary
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id
ORDER BY e.emp_id;

-- 예제 2: 모든 직원과 참여 프로젝트 (프로젝트 미참여 직원 포함)
SELECT 
    e.emp_name AS 직원명,
    COALESCE(p.project_name, '프로젝트 없음') AS 프로젝트명,
    ep.role AS 역할,
    COALESCE(ep.hours_worked, 0) AS 작업시간
FROM employees e
LEFT JOIN employee_projects ep ON e.emp_id = ep.emp_id
LEFT JOIN projects p ON ep.project_id = p.project_id
ORDER BY e.emp_name, p.project_name;

-- ============================================
-- 5. RIGHT JOIN (오른쪽 외부 조인)
-- ============================================
-- 오른쪽 테이블의 모든 데이터 + 왼쪽 테이블의 매칭 데이터

-- 예제 1: 모든 부서와 소속 직원 (직원이 없는 부서 포함)
SELECT 
    d.dept_name AS 부서명,
    d.location AS 위치,
    COALESCE(e.emp_name, '직원 없음') AS 직원명,
    e.salary AS 급여
FROM employees e
RIGHT JOIN departments d ON e.dept_id = d.dept_id
ORDER BY d.dept_id, e.emp_name;

-- ============================================
-- 6. FULL OUTER JOIN 구현
-- ============================================
-- MySQL은 FULL OUTER JOIN을 직접 지원하지 않으므로 UNION으로 구현

-- 예제: 모든 직원과 모든 부서 (매칭 여부 무관)
SELECT 
    e.emp_name AS 직원명,
    d.dept_name AS 부서명
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id

UNION

SELECT 
    e.emp_name AS 직원명,
    d.dept_name AS 부서명
FROM employees e
RIGHT JOIN departments d ON e.dept_id = d.dept_id
WHERE e.dept_id IS NULL;

-- ============================================
-- 7. CROSS JOIN (교차 조인)
-- ============================================
-- 두 테이블의 모든 조합 (카티션 곱)

-- 예제: 모든 직원과 모든 프로젝트의 조합
SELECT 
    e.emp_name AS 직원명,
    p.project_name AS 프로젝트명
FROM employees e
CROSS JOIN projects p
ORDER BY e.emp_name, p.project_name
LIMIT 20;  -- 결과가 많으므로 제한

-- ============================================
-- 8. SELF JOIN (자기 조인)
-- ============================================
-- 같은 테이블을 자기 자신과 조인

-- 예제: 직원과 매니저 정보
SELECT 
    e1.emp_name AS 직원명,
    e1.salary AS 직원급여,
    COALESCE(e2.emp_name, '최상위') AS 매니저명,
    e2.salary AS 매니저급여
FROM employees e1
LEFT JOIN employees e2 ON e1.manager_id = e2.emp_id
ORDER BY e1.emp_id;


-- ============================================
-- 9. Quiz
-- ============================================

-- 1. '서울'에 위치한 부서의 모든 직원 정보를 조회하세요.

SELECT 
    e.emp_name AS 직원명,
    d.dept_name AS 부서명,
    d.location AS 위치,
    e.salary AS 급여
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id
WHERE d.location = '서울'
ORDER BY d.dept_name, e.emp_name;

-- 2. 급여가 4,500,000원 이상인 직원의 이름, 부서명, 급여를 조회하세요.

SELECT 
    e.emp_name AS 직원명,
    d.dept_name AS 부서명,
    e.salary AS 급여
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id
WHERE e.salary >= 4500000
ORDER BY e.salary DESC;

-- 3. 프로젝트에 참여하지 않은 직원의 이름과 부서명을 조회하세요.

SELECT 
    e.emp_name AS 직원명,
    COALESCE(d.dept_name, '부서 미배정') AS 부서명,
    e.salary AS 급여
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id
LEFT JOIN employee_projects ep ON e.emp_id = ep.emp_id
WHERE ep.emp_id IS NULL
ORDER BY e.emp_name;