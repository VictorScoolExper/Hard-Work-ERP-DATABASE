<?php 

function hw_erp_crm_page(){
    ?>
    <nav class="navbar navbar-expand-lg bg-body-tertiary" style="margin: 0px 0px 0px -20px;">
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
        <div class="m-2 col-12 d-flex justify-content-center" >
            <!-- Card for contact count -->
            <div style=" margin-top: 50px; border: 3px solid black; padding: 10px; height: 10%; width: 95%; ">
                <div class="col-12" style="padding: 5px 0;">
                    <h6>Contacts</h6>
                </div>
                <div class="d-flex justify-content-center" style="text-align: center;">
                    <div class="col-6 border-end">
                        <h1 style="font-size: 8vw;">0</h1>
                        <h3>Contacts</h3>
                    </div>
                    <div class="col-6 border-start">
                        <ul class="row">
                            <li class="m-2" >
                                <span class="d-inline badge bg-primary rounded-pill" style="margin-right: 20px; height: 25px;">    </span>
                                <h5 class="d-inline" style="font-size: 3vw;">0 Customer</h5>
                            </li>
                            <li class="m-2" >
                                <span class="d-inline badge bg-success rounded-pill" style="margin-right: 20px; height: 25px;">    </span>
                                <h5 class="d-inline" style="font-size: 3vw;">0 Leads</h5>
                            </li>
                            <li class="m-2" >
                                <span class=" d-inline badge bg-warning rounded-pill" style="margin-right: 20px; height: 25px;">    </span>
                                <h5 class="d-inline" style="font-size: 3vw;">0 Opportunities</h5>
                            </li>
                        </ul>
                    </div>   
                </div>
                <button class="btn btn-primary col-12" type="button" style="margin-top: 10px;">Contacts</button>
            </div>
        </div>
    </div>
    
    <?php
}