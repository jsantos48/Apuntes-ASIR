# The proper term is pseudo_replica_mode, but we use this compatibility alias
# to make the statement usable on server versions 8.0.24 and older.
/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=1*/;
/*!50003 SET @OLD_COMPLETION_TYPE=@@COMPLETION_TYPE,COMPLETION_TYPE=0*/;
DELIMITER /*!*/;
# at 4
#260414 13:33:37 server id 1  end_log_pos 126 CRC32 0xe8fcd636 	Start: binlog v 4, server v 8.0.43-0ubuntu0.24.04.1 created 260414 13:33:37
# at 126
#260414 13:33:37 server id 1  end_log_pos 157 CRC32 0x17a1a305 	Previous-GTIDs
# [empty]
# at 157
#260414 13:39:32 server id 1  end_log_pos 236 CRC32 0xdc2b9bb1 	Anonymous_GTID	last_committed=0	sequence_number=1	rbr_only=yes	original_committed_timestamp=1776166772610074	immediate_commit_timestamp=1776166772610074	transaction_length=336
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1776166772610074 (2026-04-14 13:39:32.610074 CEST)
# immediate_commit_timestamp=1776166772610074 (2026-04-14 13:39:32.610074 CEST)
/*!80001 SET @@session.original_commit_timestamp=1776166772610074*//*!*/;
/*!80014 SET @@session.original_server_version=80043*//*!*/;
/*!80014 SET @@session.immediate_server_version=80043*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 236
#260414 13:39:32 server id 1  end_log_pos 323 CRC32 0x74218a32 	Query	thread_id=27	exec_time=0	error_code=0
SET TIMESTAMP=1776166772/*!*/;
SET @@session.pseudo_thread_id=27/*!*/;
SET @@session.foreign_key_checks=1, @@session.sql_auto_is_null=0, @@session.unique_checks=1, @@session.autocommit=1/*!*/;
SET @@session.sql_mode=1168113696/*!*/;
SET @@session.auto_increment_increment=1, @@session.auto_increment_offset=1/*!*/;
/*!\C utf8mb4 *//*!*/;
SET @@session.character_set_client=255,@@session.collation_connection=255,@@session.collation_server=255/*!*/;
SET @@session.lc_time_names=0/*!*/;
SET @@session.collation_database=DEFAULT/*!*/;
/*!80011 SET @@session.default_collation_for_utf8mb4=255*//*!*/;
BEGIN
/*!*/;
# at 323
#260414 13:39:32 server id 1  end_log_pos 406 CRC32 0xf32b824f 	Table_map: `empresa_segura`.`empleados` mapped to number 115
# has_generated_invisible_primary_key=0
# at 406
#260414 13:39:32 server id 1  end_log_pos 462 CRC32 0x6d345b73 	Write_rows: table id 115 flags: STMT_END_F
### INSERT INTO `empresa_segura`.`empleados`
### SET
###   @1=5
###   @2='Roberto'
###   @3='a@a.a'
###   @4=NULL
###   @5=NULL
###   @6=NULL
# at 462
#260414 13:39:32 server id 1  end_log_pos 493 CRC32 0x6ea3a801 	Xid = 409272
COMMIT/*!*/;
# at 493
#260414 13:39:33 server id 1  end_log_pos 537 CRC32 0x80cd9ed1 	Rotate to binlog.000233  pos: 4
SET @@SESSION.GTID_NEXT= 'AUTOMATIC' /* added by mysqlbinlog */ /*!*/;
DELIMITER ;
# End of log file
/*!50003 SET COMPLETION_TYPE=@OLD_COMPLETION_TYPE*/;
/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=0*/;
