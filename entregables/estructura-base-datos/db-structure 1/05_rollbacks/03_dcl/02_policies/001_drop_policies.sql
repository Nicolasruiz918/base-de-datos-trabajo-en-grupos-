DROP POLICY IF EXISTS pol_customer_admin_all ON configuration.customer;
DROP POLICY IF EXISTS pol_person_admin_all ON configuration.person;
DROP POLICY IF EXISTS pol_user_account_admin_all ON security.user_account;
DROP POLICY IF EXISTS pol_invoice_admin_all ON billing.invoice;
DROP POLICY IF EXISTS pol_payment_admin_all ON billing.partial_payment;
DROP POLICY IF EXISTS pol_customer_developer_all ON configuration.customer;
DROP POLICY IF EXISTS pol_person_developer_all ON configuration.person;
DROP POLICY IF EXISTS pol_user_account_developer_read ON security.user_account;
DROP POLICY IF EXISTS pol_invoice_developer_all ON billing.invoice;
DROP POLICY IF EXISTS pol_payment_developer_all ON billing.partial_payment;
DROP POLICY IF EXISTS pol_customer_qa_read ON configuration.customer;
DROP POLICY IF EXISTS pol_invoice_qa_read ON billing.invoice;


