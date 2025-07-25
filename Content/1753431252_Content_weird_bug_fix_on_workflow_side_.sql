WITH <br />
ssnInfo AS<br />
(<br />
 &nbsp; &nbsp;SELECT &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; SSN, <br />
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; UPPER(LAST_NAME) &nbsp;LAST_NAME, <br />
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; UPPER(FIRST_NAME) FIRST_NAME, <br />
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; TAXABLE_INCOME, &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<br />
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; CHARITABLE_DONATIONS<br />
 &nbsp; &nbsp;FROM IRS_MASTER_FILE<br />
 &nbsp; &nbsp;WHERE STATE = 'MN' &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; AND -- limit to in-state<br />
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;TAXABLE_INCOME > 250000 &nbsp; &nbsp; &nbsp;AND -- is rich <br />
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;CHARITABLE_DONATIONS > 5000 &nbsp; &nbsp; &nbsp;-- might donate too<br />
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<br />
),<br />
doltishApplicants AS<br />
(<br />
 &nbsp; &nbsp;SELECT SSN, <br />
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; SAT_SCORE,<br />
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; SUBMISSION_DATE<br />
 &nbsp; &nbsp;FROM COLLEGE_ADMISSIONS<br />
 &nbsp; &nbsp;WHERE SAT_SCORE < 100 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;-- About as smart as a Moose.<br />
),<br />
todaysAdmissions AS<br />
(<br />
 &nbsp; &nbsp;SELECT doltishApplicants.SSN, <br />
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; TRUNC(SUBMISSION_DATE) &nbsp;SUBMIT_DATE, <br />
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; FIRST_NAME<br />
 &nbsp; &nbsp;FROM ssnInfo,<br />
 &nbsp; &nbsp; &nbsp; &nbsp; doltishApplicants<br />
 &nbsp; &nbsp;WHERE ssnInfo.SSN = doltishApplicants.SSN<br />
<br />
)<br />
SELECT 'Dear ' || FIRST_NAME || <br />
 &nbsp; &nbsp; &nbsp; ' your admission to WhatsaMattaU has been accepted.'<br />
FROM todaysAdmissions<br />
WHERE SUBMIT_DATE = TRUNC(SYSDATE) &nbsp; &nbsp;-- For stuff received today only<br />
;