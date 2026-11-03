package com.inventory.network_inventory.entity;
import com.inventory.network_inventory.entity.enums.RouterStatus;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;


@Entity 
@Table (name="router")
public class Router {
    @Id 
   @GeneratedValue(strategy = GenerationType.IDENTITY)
   @Column(name = "id")
   private  Long id; 

   @Column(name="site_id", nullable = false)
   private Long siteId;

   @Column(name="hostname", nullable = false, length = 100, unique = true)
   private String hostName;
   
   @Column(name="vendor", nullable = false, length = 60)
   private String vendor;

   @Column (name="model", length = 60, nullable = false)
   private String model;

   @Column (name="serial_number", length=60, nullable = false, unique = true)
   private String serialNumber;

   @Column(name="management_ip", length=45)
   private String managementIp;

   @Column(name="software_version", length = 40)
   private String softwareVersion;

   @Enumerated(EnumType.STRING) 
   @Column(name="status", length = 20, nullable = false)
   private RouterStatus status;
   @CreationTimestamp 
   @Column(
      name = "created_at",
      nullable = false,
     updatable = false
   )
   private LocalDateTime createdAt;
   @UpdateTimestamp
   @Column(name = "updated_at")
   private LocalDateTime updatedAt;

   public Long getId(){return  id;}
   public void setId(Long id){this.id = id;}

    public String getHostName(){ return hostName;}
    public void setHostName(String hostName){this.hostName = hostName;}

    public String getVendor(){ return vendor;}
    public void setVendor(String vendor){this.vendor = vendor;}

    public String getModel(){return model;}
    public void setModel(String model){this.model = model;}

    public String getSerialNumber(){return serialNumber;}
    public void setSerialNumber(String serialNumber){this.serialNumber = serialNumber;}

    public String getManagementIp(){return managementIp;}
    public void setManagementIp(String managementIp){this.managementIp = managementIp;}

    public String getSoftwareVersion(){return softwareVersion;}
    public void setSoftwareVersion(String softwareVersion){this.softwareVersion = softwareVersion;}

    public RouterStatus getStatus(){return status;}

    public LocalDateTime getCreatedAt(){return createdAt;}
    public LocalDateTime getUpdatedAt(){return updatedAt;}

}
