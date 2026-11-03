package com.inventory.network_inventory.entity;

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

@Entity 
@Table(name="network_site")
public class NetworkSite {
   @Id 
   @GeneratedValue(strategy = GenerationType.IDENTITY)
   @Column(name = "id")
   private  Long id;
    
   @Column(name = "site_code", nullable = false, length = 20, unique = true)
   private String siteCode;

   @Column(name = "name", nullable = false, length = 120)
   private String name;

   @Column(name = "address", length = 255)
   private String address;

   @Column(name = "city",  length = 80)
   private String city;

   @Column(name ="country_code", length = 2, columnDefinition = "CHAR(2)" )
   private String countryCode;

   @Column(name = "latitude", precision = 9, scale = 6 )
   private BigDecimal latitude;

   @Column(name = "longitude", precision = 9, scale = 6)
   private BigDecimal longitude;

   @Column(name = "status", nullable = false, length = 20)
   private String status;
   @CreationTimestamp
   @Column(
      name = "created_at",
      nullable = false,
     updatable = false
   )
   private LocalDateTime createdAt;
   
   @UpdateTimestamp
   @Column(
      
      name = "updated_at")
   private LocalDateTime updatedAt;

   public  Long getId(){return id;}
   public void setId(Long id){
      this.id = id;
   }

   public String getSiteCode(){ return siteCode;}
   public void setSiteCode(String siteCode){this.siteCode = siteCode;}

   public String getName(){return  name;}
   public void setName(String name){
      this.name = name;
   }

   public String getAddress(){return address;}
   public void setAddress(String address){
      this.address = address;
   }
   
   public String getCity(){return  city;}
   public void setCity(String city){
      this.city = city;
   }
   public String getCountryCode(){return  countryCode;}
   public void setCountryCode(String countryCode){
      this.countryCode = countryCode;
   }
   
   public BigDecimal getLatitude() {return  latitude;}
   public void setLatitude(BigDecimal latitude){
      this.latitude = latitude;
   }
    public BigDecimal getLongitude() {return  longitude;}
   public void setLongitude(BigDecimal longitude){
      this.longitude = longitude;
   }
      public String getStatus(){return  status;}
   public void setStatus(String status){
      this.status = status;
   }
   public LocalDateTime getCreatedAt(){return createdAt;}
   public void setCreatedAt(LocalDateTime createdAt){
      this.createdAt = createdAt;
   }
   public LocalDateTime getUpdatedAt(){return updatedAt;}
   public void setUpdatedAt(LocalDateTime updatedAt){
      this.updatedAt = updatedAt;
   }
}
