INSERT INTO chart_of_accounts (account_number, account_name, account_type, normal_balance)
VALUES (
  (101, 'Cash', 'Assets', 'Debit'),
  (102, 'Accounts Receivable', 'Assets', 'Debit'),
  (103, 'Supplies', 'Assets', 'Debit'),
  (104, 'Prepaid Insurance', 'Assets', 'Debit'),
  (201, 'Accounts Payable', 'Liabilities', 'Credit'),
  (202, 'Unearned Revenue', 'Liabilities', 'Credit'),
  (301, 'Owners Capital', 'Equity', 'Credit'),
  (401, 'Maintenance Revenue', 'Revenue', 'Credit'),
  (501, 'Salaries Expense', 'Expenses', 'Debit'),
  (502, 'Rent Expense', 'Expenses', 'Debit'),
  (503, 'Supplies Expense', 'Expenses', 'Debit'),
  (504, 'Insurance Expense', 'Expenses', 'Debit')
)

INSERT INTO income (date, amount, customer_name, description)
VALUES ('2023-04-17', 50.00, 'John Smith', 'Lawn mowing service');

INSERT INTO chart_of_accounts (account_number, account_name, account_type, normal_balance)
VALUES (401, 'Maintenance Revenue', 'Revenue', 'Credit');

