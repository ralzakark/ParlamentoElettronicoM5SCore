CREATE TABLE "committee" (
                "id" serial NOT NULL,
                "name" text DEFAULT ''::text, -- Committee description
                "description" text NOT NULL DEFAULT ''::text,
                "text_search_data" tsvector,
                CONSTRAINT committe_pkey PRIMARY KEY (id));
CREATE INDEX "committee_text_search_data_idx" ON "committee" USING gin ("text_search_data");
CREATE TRIGGER "update_text_search_data"
  BEFORE INSERT OR UPDATE ON "commitee"
  FOR EACH ROW EXECUTE PROCEDURE
  tsvector_update_trigger('text_search_data', 'pg_catalog.simple',
    "name", "description");
COMMENT ON TABLE committee
  IS 'Committees formed to do research and make recommendations on a potential or planned project or change. ';
COMMENT ON COLUMN committee.name IS 'Committee description';
