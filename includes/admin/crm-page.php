<?php 

function hw_erp_crm_page(){
    ?>
    <nav class="navbar navbar-expand-lg bg-body-tertiary" style="margin: 0px 0px 0px -20px; ">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">CRM</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item">
                <a class="nav-link active" aria-current="page" href="#">Dashboard</a>
                </li>
                <li class="nav-item">
                <a class="nav-link" href="#">Contact</a>
                </li>
                <li class="nav-item">
                <a class="nav-link" href="#">Settings</a>
                </li>
            </ul>
            </div>
        </div>
    </nav>
    <div class="wrap">
        <h1>CRM Dashboard</h1>
        <!-- section contains the modules -->
        <div class="m-2 col-12" style="margin: auto;">
            <!-- Card for contact count -->
            <div class="m-3" style="border: 3px solid black; padding: 10px; height: 200px; width: 95%">
                <div class="col-12" style="padding: 5px 0;">
                    <h6>Contacts</h6>
                </div>
                <div class="d-flex justify-content-center" style="text-align: center;">
                    <div class="col-6 border-end">
                        <h1 style="font-size: 3rem;">0</h1>
                        <h4>Contacts</h4>
                    </div>
                    <div class="col-6 border-start">
                        Right
                    </div>   
                </div>
                
            </div>
        </div>
    </div>
    
    <?php
}