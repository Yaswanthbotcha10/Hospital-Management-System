USE hospital_management_db;

DROP PROCEDURE IF EXISTS sp_patient_appointments;
DROP PROCEDURE IF EXISTS sp_update_appointment_status;
DROP PROCEDURE IF EXISTS sp_record_payment;

DELIMITER $$

CREATE PROCEDURE sp_patient_appointments(IN p_patient_id INT)
BEGIN
    SELECT appointment_id, appointment_datetime, status, reason, consultation_fee
    FROM appointments
    WHERE patient_id = p_patient_id
    ORDER BY appointment_datetime DESC;
END$$

CREATE PROCEDURE sp_update_appointment_status(
    IN p_appointment_id INT,
    IN p_new_status VARCHAR(20)
)
BEGIN
    IF p_new_status NOT IN ('Scheduled','Completed','Cancelled','No-show') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid appointment status';
    END IF;

    UPDATE appointments
    SET status = p_new_status
    WHERE appointment_id = p_appointment_id;

    IF ROW_COUNT() = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Appointment not found';
    END IF;
END$$

CREATE PROCEDURE sp_record_payment(
    IN p_bill_id INT,
    IN p_amount DECIMAL(10,2),
    IN p_method VARCHAR(30),
    IN p_reference VARCHAR(100)
)
BEGIN
    IF p_amount <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Payment amount must be greater than zero';
    END IF;

    INSERT INTO payments (bill_id, payment_date, amount, payment_method, payment_status, transaction_reference)
    VALUES (p_bill_id, CURDATE(), p_amount, p_method, 'Successful', p_reference);
END$$

DELIMITER ;

-- Example calls (run separately when ready):
-- CALL sp_patient_appointments(1);
-- CALL sp_update_appointment_status(7, 'Completed');
-- CALL sp_record_payment(2, 300.00, 'UPI', 'TXN-NEW-001');
