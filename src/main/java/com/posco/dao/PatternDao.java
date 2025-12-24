package com.posco.dao;

import java.util.List;

import com.posco.domain.Pattern;

public interface PatternDao {

	List<Pattern> patternDataList();

	void patternStartDataSave(Pattern p);

	void patternStartDataForceUpdate(Pattern p);

	void patternEndDataUpdate(Pattern p);

	List<Pattern> patternEndDataList(Pattern p);

}
