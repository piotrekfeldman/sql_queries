-- Tworzy tabelę pracownik(imie, nazwisko, wyplata, data urodzenia, stanowisko). W tabeli mogą być dodatkowe kolumny, które uznasz za niezbędne.

CREATE TABLE employees (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(30),
    last_name VARCHAR(30),
    birthdate DATE,
    salary DECIMAL(10,2),
    position VARCHAR(30)
);

-- Wstawia do tabeli co najmniej 6 pracowników

INSERT INTO employees 
(first_name, last_name, birthdate, salary, position) 
VALUES 
('Maria' , 'Kowalska', '1989-09-24', 3500.00, 'accountant'),
('Jan' , 'Nowacki', '1981-09-24', 4500.00, 'it'),
('Kasia' , 'Jabłczyńska', '1995-01-14', 2500.00, 'it'),
('Miłosz' , 'Polak', '1979-09-24', 25000.00, 'ceo'),
('Piotr' , 'Szumowski', '1986-03-01', 3500.00, 'customer relation specialist'),
('Jakub' , 'Krajewski', '1993-03-24', 15000.00, 'it');

-- Pobiera wszystkich pracowników i wyświetla ich w kolejności alfabetycznej po nazwisku

SELECT * FROM employees ORDER BY last_name ASC;

-- Pobiera pracowników na wybranym stanowisku

SELECT * FROM employees WHERE position='it';

-- Pobiera pracowników, którzy mają co najmniej 30 lat

SELECT * FROM employees WHERE YEAR (birthdate) <= 1991;

-- Zwiększa wypłatę pracowników na wybranym stanowisku o 10%

SELECT *, (salary*0.1 + salary) AS raised_salary FROM employees;

-- Pobiera najmłodszego pracowników (uwzględnij przypadek, że może być kilku urodzonych tego samego dnia)

SELECT * FROM employees WHERE birthdate = (SELECT MAX(birthdate) FROM employees);

-- Usuwa tabelę pracownik

DROP TABLE employees;
 
--  Tworzy tabelę stanowisko (nazwa stanowiska, opis, wypłata na danym stanowisku)

CREATE TABLE position (
    id INT PRIMARY KEY AUTO_INCREMENT,
    position_name VARCHAR(30) UNIQUE NOT NULL,
    description VARCHAR(30),
    salary DECIMAL(10,2) NOT NULL
);

-- Tworzy tabelę adres (ulica+numer domu/mieszkania, kod pocztowy, miejscowość)

CREATE TABLE address (
    id INT PRIMARY KEY AUTO_INCREMENT,
    street_name VARCHAR(30) NOT NULL,	
    street_number VARCHAR(30) NOT NULL,
    postal_code VARCHAR(10),
    city VARCHAR(30) NOT NULL
);

-- Tworzy tabelę pracownik (imię, nazwisko) + relacje do tabeli stanowisko i adres

CREATE TABLE employee (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    position_id INT NOT NULL,
    address_id INT UNIQUE NOT NULL,
    FOREIGN KEY (position_id) REFERENCES position (id),
	FOREIGN KEY (address_id) REFERENCES address (id)
);

-- Dodaje dane testowe (w taki sposób, aby powstały pomiędzy nimi sensowne powiązania)

INSERT INTO position
(position_name, description, salary)
VALUES
('Java developer', 'Programista Java', 22000),
('Frontend developer', 'Programista frontend', 15000),
('QA', 'Tester oprogramowania', 8000);

INSERT INTO address
(street_name, street_number, postal_code, city )
VALUES
('Podwale', '30/1', '11-222', 'Wrocław'),
('Legnicka', '10/4', '42-222', 'Wrocław'),
('Oławska', '24', '42-222', 'Wrocław'),
('Kościuszki', '13', '11-222', 'Wrocław'),
('Kozanowska', '50/4', '41-222', 'Wrocław');


INSERT INTO employee
(first_name, last_name, position_id, address_id)
VALUES
('Maria' , 'Kowalska', 1, 1),
('Jan' , 'Nowacki', 2,2),
('Kasia' , 'Jabłczyńska', 3, 3),
('Miłosz' , 'Polak', 1,4),
('Piotr' , 'Szumowski', 2, 5);

-- Pobiera pełne informacje o pracowniku (imię, nazwisko, adres, stanowisko)

select e.first_name as imię, e.last_name as nazwisko, a.street_name as ulica, a.street_number as numer_ulicy, a.postal_code as kod_pocztowy, a.city as miasto, p.position_name as stanowisko from employee e
join address a ON e.address_id = a.id
join position p ON e.position_id = p.id;

-- Oblicza sumę wypłat dla wszystkich pracowników w firmie

select sum(salary) as suma_wypłat from position;

-- Pobiera pracowników mieszkających w lokalizacji z kodem pocztowym 90210 (albo innym, który będzie miał sens dla Twoich danych testowych)

select e.first_name as imię, e.last_name as nazwisko, a.street_name as ulica, a.street_number as numer_ulicy, a.postal_code as kod_pocztowy, a.city as miasto from employee e
join address a ON e.address_id = a.id
where a.postal_code='11-222';

