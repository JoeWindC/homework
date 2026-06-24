package com.ouyeni.ylggxt.mapper;

import com.ouyeni.ylggxt.entity.Registration;
import org.apache.ibatis.annotations.Param;

import java.util.List;

// 挂号预约表 MyBatis 映射接口。
public interface RegistrationMapper {
    List<Registration> findAll();

    List<Registration> findByUserId(Integer userId);

    List<Registration> findQueueList();

    int countAll();

    int countPending();

    int insert(Registration registration);

    int updateStatus(@Param("id") Integer id, @Param("status") String status);

    int deleteById(@Param("id") Integer id, @Param("userId") Integer userId);
}
