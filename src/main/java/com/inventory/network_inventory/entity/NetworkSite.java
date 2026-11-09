package com.inventory.network_inventory.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import com.inventory.network_inventory.entity.enums.SiteStatus;

@Entity 
@Table(name="network_site", uniqueConstraints={
   @UniqueConstraint(name="UQ_network_site_site_code", columnNames = {"site_code"})
})
public class NetworkSite {
   @Id 
   @GeneratedValue(strategy = GenerationType.IDENTITY)
   @Column(name = "id")
   private  Long id;
    
   @Column(name = "site_code", nullable = false, length = 20)
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

   @Enumerated(EnumType.STRING)
   @Column(name = "status", nullable = false, length = 20)
   private SiteStatus status;
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
   
   @OneToMany(mappedBy = "site")
   private List<Router> routers = new ArrayList<>();

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
      public SiteStatus getStatus(){return  status;}
   public void setStatus(SiteStatus  status){
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
   public List<Router> getRouters(){return routers;}
}
