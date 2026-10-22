USE hospital_management_db;

DROP TRIGGER IF EXISTS trg_appointment_status_history;
DROP TRIGGER IF EXISTS trg_payment_not_over_bill;

DELIMITER $$

CREATE TRIGGER trg_appointment_status_history
AFTER UPDATE ON appointments
FOR EACH ROW
BEGIN
    IF OLD.status <> NEW.status THEN
        INSERT INTO appointment_status_history
            (appointment_id, old_status, new_status, changed_at, remarks)
        VALUES
            (NEW.appointment_id, OLD.status, NEW.status, CURRENT_TIMESTAMP, 'Status updated');
    END IF;
END$$

CREATE TRIGGER trg_payment_not_over_bill
BEFORE INSERT ON payments
FOR EACH ROW
BEGIN
    DECLARE v_bill_amount DECIMAL(10,2);
    DECLARE v_paid_amount DECIMAL(10,2);

    IF NEW.payment_status = 'Successful' THEN
        SELECT amount INTO v_bill_amount
        FROM bills WHERE bill_id = NEW.bill_id;

        SELECT COALESCE(SUM(amount), 0) INTO v_paid_amount
        FROM payments
        WHERE bill_id = NEW.bill_id AND payment_status = 'Successful';

        IF v_paid_amount + NEW.amount > v_bill_amount THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Payment exceeds remaining bill balance';
        END IF;
    END IF;
END$$

DELIMITER ;
