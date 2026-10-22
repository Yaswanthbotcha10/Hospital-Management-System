USE hospital_management_db;

-- 1. Bill-level balance and payment state.
SELECT * FROM vw_bill_balances
ORDER BY balance_due DESC;

-- 2. Total bills, successful payments, and outstanding balance.
SELECT
    (SELECT COUNT(*) FROM bills) AS total_bills,
    (SELECT COALESCE(SUM(amount),0) FROM bills) AS total_billed,
    (SELECT COALESCE(SUM(amount),0) FROM payments WHERE payment_status = 'Successful') AS total_successful_payments,
    (SELECT COALESCE(SUM(balance_due),0) FROM vw_bill_balances) AS total_outstanding;

-- 3. Revenue by payment method (successful payments only).
SELECT payment_method, SUM(amount) AS collected_amount, COUNT(*) AS payment_count
FROM payments
WHERE payment_status = 'Successful'
GROUP BY payment_method
ORDER BY collected_amount DESC;

-- 4. Monthly billing totals.
SELECT DATE_FORMAT(bill_date, '%Y-%m') AS billing_month,
       SUM(amount) AS total_billed, COUNT(*) AS bills_issued
FROM bills
GROUP BY DATE_FORMAT(bill_date, '%Y-%m')
ORDER BY billing_month;

-- 5. Patients with outstanding balances.
SELECT patient_id, patient_name, SUM(balance_due) AS total_due
FROM vw_bill_balances
WHERE balance_due > 0
GROUP BY patient_id, patient_name
ORDER BY total_due DESC;

-- 6. Bills that are partially paid or unpaid.
SELECT bill_id, patient_name, bill_amount, amount_paid, balance_due, payment_state
FROM vw_bill_balances
WHERE payment_state IN ('Partially Paid','Unpaid')
ORDER BY balance_due DESC;
