CREATE TABLE "committee" (
                "id"            SERIAL4 PRIMARY KEY,
                "name"          TEXT NOT NULL DEFAULT ''::text, -- Committee description
                "description"   TEXT DEFAULT ''::text,
                "text_search_data" tsvector);
CREATE INDEX "committee_text_search_data_idx" ON "committee" USING gin ("text_search_data");
CREATE TRIGGER "update_text_search_data" BEFORE INSERT OR UPDATE ON "committee" FOR EACH ROW EXECUTE PROCEDURE tsvector_update_trigger('text_search_data', 'pg_catalog.simple', "name", "description");
COMMENT ON TABLE "committee" IS 'Committees formed to do research and make recommendations on a potential or planned project or change. ';
COMMENT ON COLUMN "committee"."name" IS 'Committee description';

CREATE TABLE "committee_request" (
		PRIMARY KEY ("committee_id", "member_id", "issue_id"),	
		"committee_id"  INT4 REFERENCES "committee" ("id") ON DELETE CASCADE ON UPDATE CASCADE, 
		"member_id"     INT4 REFERENCES "member" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
		"issue_id"      INT4 REFERENCES "issue" ("id") ON DELETE CASCADE ON UPDATE CASCADE);
COMMENT ON TABLE "committee_request" IS 'Member committee request for an issue';
