require_relative 'abstract_mapper'

class FunctionMapper < AbstractMapper

  def map_record(obj, json, solr_doc)
    super
  end

  def parse_whitelisted_json(obj, json)
    whitelisted = super

    whitelisted['qsa_id'] = json.qsa_id
    whitelisted['qsa_id_prefixed'] = json.qsa_id_prefixed

    whitelisted['display_string'] = json.display_string
    whitelisted['title'] = json.title
    whitelisted['source'] = json.source
    whitelisted['note'] = json.note
    whitelisted['date'] = parse_date(json.date)
    whitelisted['function_relationships'] = parse_series_system_rlshps(json.series_system_function_relationships, 'series_system_function_function_containment_relationship')
    whitelisted['agent_relationships'] = parse_series_system_rlshps(json.series_system_agent_relationships, 'series_system_agent_function_administers_relationship')
    whitelisted['mandate_relationships'] = parse_series_system_rlshps(json.series_system_mandate_relationships, ['series_system_function_mandate_creation_relationship', 'series_system_function_mandate_association_relationship', 'series_system_function_mandate_abolition_relationship'])

    whitelisted
  end

  def parse_date(date)
    return if date.nil?

    {
      'begin' => date['begin'],
      'end' => date['end'],
      'certainty' => date['certainty'],
      'certainty_end' => date['certainty_end'],
      'date_notes' => date['date_notes'],
    }
  end
end